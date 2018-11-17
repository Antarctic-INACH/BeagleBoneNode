# Author K. Herman 
# kherman@ubiobio.cl
# Simple program to send CAN frames from Julia

# sender can addres
addr = "55A";

while true
	# random frame generation
	tmp = 255*rand(1);
	d1 = Int(ceil(tmp[1]));
	tmp = 255*rand(1);
	d2 = Int(ceil(tmp[1]));
	data1 = parse(UInt8, "$d1", base=10);
	data2 = parse(UInt8, "$d2", base=10);
	data1 = string(data1, base=16, pad=2);
	data2 = string(data2, base=16, pad=2);

    println("$data1 $data2");
	#build command
	cmd = `cansend can0  $addr#$data1$data2`;
	#run command
	run(cmd);

sleep(0.1);
end 
