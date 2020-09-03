function [newy,newt,newCollision] = rkStep(y,t,m,results,amps,h,totalCollisions)
% % Euler:
% [ydotvals1,newCollision] = ydotPaul(y,t,m,results,amps,RFfreq);
% k1 = h * ydotvals1;
% newy = y + k1;
% newt = t + h;

%RK4:
[ydotvals1,newCollision1] = ydot(y,t,m,results,amps);
k1 = h * ydotvals1;

[ydotvals2,newCollision2] = ydot(y+(k1/2),t+(h/2),m,results,amps);
k2 = h * ydotvals2;

[ydotvals3,newCollision3] = ydot(y+(k2/2),t+(h/2),m,results,amps);
k3 = h * ydotvals3;

[ydotvals4,newCollision4] = ydot(y+k3,t+h,m,results,amps);
k4 = h * ydotvals4;

newy = y + ((k1 + (2*k2) + (2*k3) + k4) /6); %this line is RK4
newt = t + h;
newCollision = (newCollision1 + newCollision2 + newCollision3 + newCollision4) / 4;


if totalCollisions > length(results)*5
    newy = y;
    newCollision = 1;
end