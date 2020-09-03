function [trajectory,simTimes] = trajectoryTOFDetector(results,y0,T,m)
 % y0 = [ x y z vx vy vz], enter in mm
 % results = [resultAccel, resultEinzel, resultDetector]
 % All should be at 1 V amplitude

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
while t < T
    switchTime1 = 3.41e-6;
    if t < switchTime1
        amps = [0 24.3 -2000];
    else
        amps = [90 24.3 -2000];
    end
    
    [newy,newt,newCollision] = rkStep(y,t,m,results,amps,h,totalCollisions);
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
importGeometry(showModel,'TOFDetectorShow.stl');
pdegplot(showModel,'FaceAlpha',0.1);
hold on
plot3(trajectory(:,1),trajectory(:,2),trajectory(:,3));
xlim([-25 25]);
ylim([-25 25]);
zlim([-50 420]);
view(0,0)
camroll(-90)
