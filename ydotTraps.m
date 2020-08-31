function [ydotVals,newCollision] = ydotTraps(ytraj,t,m,results,amps,RFfreq) %see https://en.wikipedia.org/wiki/Runge%E2%80%93Kutta_methods
ydotVals = ytraj * 0;
mass = 1.66054e-27 * m;
charge = 1.60218e-19;
Omega = 2 * pi * RFfreq;

gradX = 0;
gradY = 0;
gradZ = 0;

x = ytraj(1)*1e3;
y = ytraj(2)*1e3;
z = ytraj(3)*1e3;
newCollision = 0;

for i = 1:(length(results)-1)
    [tempgradX,tempgradY,tempgradZ] = evaluateGradient(results(i),x,y,z);
        if isnan(tempgradX) || isnan(tempgradY) || isnan(tempgradZ)
            newCollision = newCollision + 1;
            if isnan(tempgradX)
                tempgradX = 0;
            end
            if isnan(tempgradY)
                tempgradY = 0;
            end
            if isnan(tempgradZ)
                tempgradZ = 0;
            end
        end

        gradX = gradX + (amps(i) * tempgradX);
        gradY = gradY + (amps(i) * tempgradY);
        gradZ = gradZ + (amps(i) * tempgradZ);
end
[tempRFgradX,tempRFgradY,tempRFgradZ] = evaluateGradient(results(end),x,y,z);
    if isnan(tempRFgradX) || isnan(tempRFgradY) || isnan(tempRFgradZ)
        newCollision = newCollision + 1;
        if isnan(tempRFgradX)
            tempRFgradX = 0;
        end
        if isnan(tempRFgradY)
            tempRFgradY = 0;
        end
        if isnan(tempRFgradZ)
            tempRFgradZ = 0;
        end
    end
    
gradX = gradX + (amps(end) * cos(Omega * t) * tempRFgradX);
gradY = gradY + (amps(end) * cos(Omega * t) * tempRFgradY);
gradZ = gradZ + (amps(end) * cos(Omega * t) * tempRFgradZ);

Ex = gradX * -1e3;
Ey = gradY * -1e3;
Ez = gradZ * -1e3;

forcex = charge * Ex;  
forcey = charge * Ey; 
forcez = charge * Ez;

ydotVals(1:3) = ytraj(4:6);
ydotVals(4) = forcex/mass; %dv_x/dt = f_x/m
ydotVals(5) = forcey/mass; %dv_x/dt = f_x/m
ydotVals(6) = forcez/mass; %dv_x/dt = f_x/m


