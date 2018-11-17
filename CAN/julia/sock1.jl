# Author K. Herman 
# kherman@ubiobio.cl
# Simple program to receive CAN framaes via TCP/IP Socket 

using Sockets

ipaddr = "192.168.4.65";
port = 28700;

sock = connect(ipaddr, port)
	while true
		tmp = readline(sock);
		raw_frame = tmp[26:length(tmp)];
		addr = raw_frame[1:3]; 
		data = raw_frame[5:length(raw_frame)];
		println(addr);
		DataNum = Int(length(data)/2);
		pdata = zeros(1,DataNum);
		if(DataNum !=0)
	   		k=0;
			for i= 1  : DataNum
				d = data[2*i-1:2*i];
				t = parse(Int, d, base=16)
				pdata[i] = Int(t);
			end
   		end
    println(pdata)
	end

close(sock)
