function [trajectory,simTimes] = trajectoryFullLoading(results,y0,T,m)
 % y0 = [ x y z vx vy vz], enter in mm
 % results = [resultAccel, resultEinzel, resultGateTop, resultGateBottom]
 % All should be at 1 V amplitude
RFfreq = 2e6;
 
accelOnTime = 3.41e-6;
gateOffTime = 34.325e-6;
gateOnTime = 34.825e-6;
paulOffTime = 42.0e-6;
paulOnTime = 52.0e-6;
 
if nargin < 4
    m = 88;
end
y = y0 * 1e-3;
h = 1e-9;
numTimes = round(T / h);
simTimes = zeros(numTimes,1);
simTimes(1) = 0;
trajectory = zeros(numTimes,6);
trajectory(1,:) = y;
t = 0;
i = 2;
totalCollisions = 0;
angFreq = 2 * pi * RFfreq;
while t < T
    currentZ = y(3)*1e3;
    if currentZ < 367
        resultsTemp = results(1:2);
        zOffset = 0;
        if t < accelOnTime
            amps = [0 24.3];
        else
            amps = [90 24.3];
        end
    elseif currentZ >= 367 && currentZ < 401
        resultsTemp = results(3:4);
        zOffset = 365.5;
        if (t < gateOffTime) || (t > gateOnTime)
            amps = [20 -20];
        else
            amps = [0 0];
        end
    else
        resultsTemp = results(5:10);
        zOffset = 446;
        if (t < paulOffTime) || (t > paulOnTime)
            amps = [88 0 60 0 60 100*cos(angFreq * t)];
        else
            amps = [0 0 60 0 60 100*cos(angFreq * t)];
        end
    end
    yOffset = y;
    yOffset(3) = yOffset(3) - zOffset*1e-3;
    [newy,newt,newCollision] = rkStep(yOffset,t,m,resultsTemp,amps,h,totalCollisions);
    newy(3) = newy(3) + zOffset*1e-3;
    y = newy;
    t = newt;
    trajectory(i,:) = y;
    simTimes(i) = t;
    i = i+1;
    if newCollision > 0
        totalCollisions = totalCollisions + newCollision;
    else
        totalCollisions = 0;
    end
    if mod(i-2,5000) == 0
        fprintf('Time: %0.1f microseconds \n',t*1e6);
    end
end

trajectory = trajectory * 1e3; %Converting back to mm

showModel = createpde();
importGeometry(showModel,'FullLoadingShow.stl');
pdegplot(showModel,'FaceAlpha',0.1);
hold on
plot3(trajectory(:,1),trajectory(:,2),trajectory(:,3));
xlim([-25 25]);
ylim([-25 25]);
zlim([365 550]);
view(90,0)
camroll(-90)
