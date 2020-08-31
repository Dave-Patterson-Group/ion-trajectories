function [newy,newt,newCollision] = rkStepTraps(y,t,m,results,amps,RFfreq,h,totalCollisions)
% % Euler:
% [ydotvals1,newCollision] = ydotPaul(y,t,m,results,amps,RFfreq);
% k1 = h * ydotvals1;
% newy = y + k1;
% newt = t + h;

%RK4:
[ydotvals1,newCollision1] = ydotTraps(y,t,m,results,amps,RFfreq);
k1 = h * ydotvals1;

[ydotvals2,newCollision2] = ydotTraps(y+(k1/2),t+(h/2),m,results,amps,RFfreq);
k2 = h * ydotvals2;

[ydotvals3,newCollision3] = ydotTraps(y+(k2/2),t+(h/2),m,results,amps,RFfreq);
k3 = h * ydotvals3;

[ydotvals4,newCollision4] = ydotTraps(y+k3,t+h,m,results,amps,RFfreq);
k4 = h * ydotvals4;

newy = y + ((k1 + (2*k2) + (2*k3) + k4) /6); %this line is RK4
newt = t + h;
newCollision = (newCollision1 + newCollision2 + newCollision3 + newCollision4) / 4;


if totalCollisions > length(results)*3
    newy = y;
    newCollision = 1;
end