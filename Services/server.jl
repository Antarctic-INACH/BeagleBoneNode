###############################################################################
# Julia Main Server for managing the NoctWarming system  
# Author K. Herman
# kherman@ubiobio.cl
############################################################################### 

###############################################################################
using Sockets;
using Syslogs;
using JuliaDB;
#using Dates;
#using SQLite;
###############################################################################

# hostname definition
hostname = "BB-2";
# main port definition
port = 2037;
# log handler
global log = Syslog();


###############################################################################
#                           Function reads
include("canread.jl");
include("MLX90614.jl");
include("DS18B20read.jl");

###############################################################################
# asynchronous task for the server  
@async begin
	server = listen(port);
    while true
	    sock = accept(server);
        try
	    @async while isopen(sock);
	 				line = readline(sock, keep=true)
					if line == "takephoto\n"
			        	write(sock, "$hostname Taking Photo\n");
					elseif line == "takemeasure\n"
				        write(sock, "$hostname Taking Measurement\n");
		            elseif line ==  "SendSMS\n"
					    write(sock, "$hostname Sending Message\n");			
		            elseif line ==  "ReadMLX\n"
                        write(sock, "$hostname About to ReadMLX\n");
                        temperature = MLXread(1,0x5a);  
                        air = DS18B20read();
                        db = load("dump.db");
                        umeas = table([temperature], [air], names=[:PlantTemp, :AirTemp]);
                        db = merge(db,umeas);
                        save(db, "dump.db");
					    write(sock, "$hostname Temperature Value = $temperature, Air Temperature = $air\n");		                 
					elseif line == "close\n"                             
					    write(sock, "Close and Exit Task\n");
		            	close(sock);
		           	 	close(server);
		           		break;
					else
					    write(sock, "$hostname Invalid Command\n");
		            end
		       end
		catch  err
			   println(log, :info, "$hostname srv log $err");
               close(sock);
               close(server);
        end 
	end
end
###############################################################################
