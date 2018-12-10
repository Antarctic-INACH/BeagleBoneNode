# Julia Server 
# Author K. Herman
# echo takephoto | nc -q1 localhost 2037
using Sockets
using Syslogs;

hostname = "BB-2";
port = 2037;
log = Syslog();

@async begin
           server = listen(port);
           while true
               sock = accept(server);
		        try
		           @async while isopen(sock);
						   # do your stuff here
				           line = readline(sock, keep=true)
				           if line == "takephoto\n"
				          		 write(sock, "$hostname Taking Photo\n");
				           elseif line == "takemeasure\n"
				                 write(sock, "$hostname Taking Measurement\n");
							# ------------------------------------------------------- test more				
				           elseif line == "close\n"
				                 write(sock, "Close and Exit Task\n");
                                 close(sock);
                                 close(server);
                                 break;
				           else
								 write(sock, "$hostname Invalid Command\n");
                           end
		           	   end
	 
		        catch err
					print(log, :info, "$hostname srv log $err");
           	    end 
           end
      end

