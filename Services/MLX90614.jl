###############################################################################
# Author K. Herman 
# kherman@ubiobio.cl
# function to read MLX90614 sensor data
###############################################################################

function MLXread(i2c, addr)
    value = -1000;
	try 
		str = read(`i2cget -y $i2c $addr 0x07 wp`, String);
        value = parse(Int, str[3:6], base=16)*0.02 - 273.15;
    catch err
		println(log,:info,"$hostname MLX9014 read error $err");
        return -1000;
    end
 return value;
end
###############################################################################
