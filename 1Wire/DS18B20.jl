# Author K. Herman
# Email: kherman@ubiobio.cl
# Julia script for reading temperature from DS18B20 sensor

w1="/sys/bus/w1/devices/28-00000856826a/w1_slave";
w2="/sys/bus/w1/devices/28-00000864f68a/w1_slave";

while true
result= zeros(1,2);
open(w1) do f
   line = 1
   while !eof(f)
     x = readline(f)
     line += 1
	if(line==3)
          str = x[30:end];
          result[1] = parse(Int,str)/1000;
        end 
   end
end
open(w2) do f
   line = 1
   while !eof(f)
     x = readline(f)
     line += 1
	if(line==3)
          str = x[30:end];
          result[2] = parse(Int,str)/1000;
        end 
   end
 end
println("final $result");
sleep(1);
end
