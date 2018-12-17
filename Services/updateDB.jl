###############################################################################
# Author K. Herman 
# kherman@ubiobio.cl
# functions to manage databases using JuliaDB
###############################################################################

###############################################################################
# databases
# each database contains main file "maindb" and unit measurement database "ummaindb"
# the main db updates using  maindb = merge(maindb, ummaindb)
# principal database framework
# db = table([], [], names=[:Timestamp, :PlantTemp, :AirTemp],  pkey=(:Timestamp);
# ArmTempDB = table([], [], [], [], [],[], names=[:No, :Ptemp1, :Ptemp2, :Ptemp3,
# :Ptemp4, :Ptemp4], pkey=(:No));
# ArmStatusDB
# ControlDB
# SystemStatusDB
###############################################################################

function initDB(dbtype)
    if dbtype == "main"
	db = table([], [], [], [], names=[:Timestamp, :AirTemp, :]);
    	return db;
    else
	return -1;
    end
end
###############################################################################


# apply functions x->f(x) to calculate the PID value
# using reduce & Online Stats
# stats = reduce((Mean(), min, max), armdbtemp[end-2:end], select=:Ptemp1)
# dropna NaN Use NA !!!

#timestamp 
# using Dates
# t = Dates.now()
# st = string(t)
# TimeStamp = st[1: end-3];

# plotting
# 
# ioff()
# PyPlot.svg(true)
# plot(rand(10,1))
# save("filename.svg")


#run(pipeline(`echo AT + CSQ`, `grep  CSQ:`));



