cp /docker_shared/pickupdelivery.cfg .
cp /docker_shared/pickupdelivery.cl .
cp /docker_shared/simulate.py .
cp /docker_shared/Omega2dSimulator.py ../../interface/python/
cp /docker_shared/rover.png .
oclgrind pfaces -CG -l
oclgrind pfaces -CG -d 1 -k omega@../../kernel-pack -cfg pickupdelivery.cfg
