############################################################################### 
# Julia script for reading temperature from DS18B20 sensor 
# Author K. Herman
# kherman@ubiobio.cl
############################################################################### 

function DS18B20read()

	w1="/sys/bus/w1/devices/28-00000856826a/w1_slave";
	result = 0.0;
    open(w1) do f
		line = 1;
		   	while !eof(f)
				x = readline(f)
			 	line += 1
				if line==3
					str = x[30:end];
			   	    result = parse(Int,str)/1000;
				end 
		    end
		end
	return result;
end 
############################################################################### 
