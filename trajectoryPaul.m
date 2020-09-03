function [trajectory,simTimes] = trajectoryPaul(results,y0,T,m)
 % y0 = [ x y z vx vy vz], enter in mm
 % results = [resultFarLeftDC resultLeftDC resultMiddleDC resultRightDC resultFarRightDC resultRF]
 % All should be at 1 V amplitude
RFfreq = 2e6; % Hz

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
    amps = [60 60 0 60 60 100*cos(angFreq * t)]; % <== Change Voltages here
%     switchTime1 = 4e-6;
%     switchTime2 = 14e-6;
%     if t < switchTime1
%         amps = [60 60 0 60 60 100*cos(angFreq * t)];
%     elseif t >= switchTime1 && t < switchTime2
%         amps = [60 60 0 60 60 100*cos(angFreq * t)];
%
%     else
%         amps = [60 60 0 60 60 100*cos(angFreq * t)];
%     end
    
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
importGeometry(showModel,'PaulShow.stl');
pdegplot(showModel);
hold on
plot3(trajectory(:,1),trajectory(:,2),trajectory(:,3));
xlim([-5 90]);
ylim([-15 15]);
zlim([-15 15]);
view(20,5)
