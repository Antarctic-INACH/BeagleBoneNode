import time
 
w1="/sys/bus/w1/devices/28-00000856826a/w1_slave"
w2="/sys/bus/w1/devices/28-00000864f68a/w1_slave"
while True:
    raw1 = open(w1, "r").read()
    raw2 = open(w2,"r").read()
    print "Temperature T1 is:  "+str(float(raw1.split("t=")[-1])/1000)+ " degrees"
    print "Temperature T2 is:  "+str(float(raw2.split("t=")[-1])/1000)+ " degrees"
    time.sleep(1)
