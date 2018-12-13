###############################################################################
# Author K. Herman 
# kherman@ubiobio.cl
# function to read can framaes from TCP/IP Socket of the canlogserver
###############################################################################

function canread(port)

	ipaddr = "localhost";
    hostname = "BB-2";
	pdata = zeros(1,1);
	try 
		sock = connect(ipaddr, port);
		tmp = readline(sock);
		raw_frame = tmp[26:length(tmp)];
		addr = raw_frame[1:3]; 
		data = raw_frame[5:length(raw_frame)];
		DataNum = Int(length(data)/2);
		pdata = zeros(1,DataNum);
			if(DataNum !=0)
		   		k=0;
				for i= 1 : DataNum
					d = data[2*i-1:2*i];
					t = parse(Int, d, base=16)
					pdata[i] = Int(t);
				end
	   		end
	close(sock);
    catch err
		println(log,:info,"$hostname CAN socket error $err");
        return -1;
    finally 
    	return pdata;
    end
end
###############################################################################
