function result = paulFields(i,v)
if nargin < 2
    v = 1;
end

model = createpde();
importGeometry(model,'Paul.stl');

% figure;
% pdegplot(model,'FaceLabels','on','FaceAlpha',0.15);
% xlabel('x');
% ylabel('y');
% zlabel('z');
% title('Geometry of system');

if i == 1
    applyBoundaryCondition(model,'dirichlet','face',1:6,'u',0); % Ground Boundaries
    
    applyBoundaryCondition(model,'dirichlet','face',[22:33, 34:45],'u',0); % RF

    applyBoundaryCondition(model,'dirichlet','face',[19:21, 46:48],'u',v); % Far left DC
    applyBoundaryCondition(model,'dirichlet','face',[7:9, 49:51],'u',0); % Left DC
    applyBoundaryCondition(model,'dirichlet','face',[10:12, 52:54],'u',0); % Middle DC
    applyBoundaryCondition(model,'dirichlet','face',[16:18, 55:57],'u',0); % Right DC
    applyBoundaryCondition(model,'dirichlet','face',[13:15, 58:60],'u',0); % Far Right DC
elseif i == 2
    applyBoundaryCondition(model,'dirichlet','face',1:6,'u',0); % Ground Boundaries
    
    applyBoundaryCondition(model,'dirichlet','face',[22:33, 34:45],'u',0); % RF

    applyBoundaryCondition(model,'dirichlet','face',[19:21, 46:48],'u',0); % Far left DC
    applyBoundaryCondition(model,'dirichlet','face',[7:9, 49:51],'u',v); % Left DC
    applyBoundaryCondition(model,'dirichlet','face',[10:12, 52:54],'u',0); % Middle DC
    applyBoundaryCondition(model,'dirichlet','face',[16:18, 55:57],'u',0); % Right DC
    applyBoundaryCondition(model,'dirichlet','face',[13:15, 58:60],'u',0); % Far Right DC
elseif i == 3
    applyBoundaryCondition(model,'dirichlet','face',1:6,'u',0); % Ground Boundaries
    
    applyBoundaryCondition(model,'dirichlet','face',[22:33, 34:45],'u',0); % RF

    applyBoundaryCondition(model,'dirichlet','face',[19:21, 46:48],'u',0); % Far left DC
    applyBoundaryCondition(model,'dirichlet','face',[7:9, 49:51],'u',0); % Left DC
    applyBoundaryCondition(model,'dirichlet','face',[10:12, 52:54],'u',v); % Middle DC
    applyBoundaryCondition(model,'dirichlet','face',[16:18, 55:57],'u',0); % Right DC
    applyBoundaryCondition(model,'dirichlet','face',[13:15, 58:60],'u',0); % Far Right DC
elseif i == 4
    applyBoundaryCondition(model,'dirichlet','face',1:6,'u',0); % Ground Boundaries
    
    applyBoundaryCondition(model,'dirichlet','face',[22:33, 34:45],'u',0); % RF

    applyBoundaryCondition(model,'dirichlet','face',[19:21, 46:48],'u',0); % Far left DC
    applyBoundaryCondition(model,'dirichlet','face',[7:9, 49:51],'u',0); % Left DC
    applyBoundaryCondition(model,'dirichlet','face',[10:12, 52:54],'u',0); % Middle DC
    applyBoundaryCondition(model,'dirichlet','face',[16:18, 55:57],'u',v); % Right DC
    applyBoundaryCondition(model,'dirichlet','face',[13:15, 58:60],'u',0); % Far Right DC
elseif i == 5
    applyBoundaryCondition(model,'dirichlet','face',1:6,'u',0); % Ground Boundaries
    
    applyBoundaryCondition(model,'dirichlet','face',[22:33, 34:45],'u',0); % RF

    applyBoundaryCondition(model,'dirichlet','face',[19:21, 46:48],'u',0); % Far left DC
    applyBoundaryCondition(model,'dirichlet','face',[7:9, 49:51],'u',0); % Left DC
    applyBoundaryCondition(model,'dirichlet','face',[10:12, 52:54],'u',0); % Middle DC
    applyBoundaryCondition(model,'dirichlet','face',[16:18, 55:57],'u',0); % Right DC
    applyBoundaryCondition(model,'dirichlet','face',[13:15, 58:60],'u',v); % Far Right DC
elseif i == 6
    applyBoundaryCondition(model,'dirichlet','face',1:6,'u',0); % Ground Boundaries
    
    applyBoundaryCondition(model,'dirichlet','face',[22:33, 34:45],'u',v); % RF

    applyBoundaryCondition(model,'dirichlet','face',[19:21, 46:48],'u',0); % Far left DC
    applyBoundaryCondition(model,'dirichlet','face',[7:9, 49:51],'u',0); % Left DC
    applyBoundaryCondition(model,'dirichlet','face',[10:12, 52:54],'u',0); % Middle DC
    applyBoundaryCondition(model,'dirichlet','face',[16:18, 55:57],'u',0); % Right DC
    applyBoundaryCondition(model,'dirichlet','face',[13:15, 58:60],'u',0); % Far Right DC
end

specifyCoefficients(model,'m',0,'d',0,'c',1,'a',0,'f',0);
%Laplace's equation: https://www.mathworks.com/help/pde/ug/equations-you-can-solve.html

generateMesh(model,'hmax',0.7);
result = solvepde(model);


% [X,Y,Z] = meshgrid(-20:105,-8:8,-8:8);
% V = interpolateSolution(result,X,Y,Z);
% V = reshape(V,size(X));
% %Creates a new mesh which is just a simple grid, instead of the complicated
% %one from before, and interpolates the function to each point on the grid
% 
% showModel = createpde();
% importGeometry(showModel,'/home/luca/Desktop/Patterson_Group_Projects/PDEs/STLs/FinalPaulInvert.stl');
% 
% figure(2);
% pdegplot(showModel);
% hold on
% colormap jet;
% contourslice(X,Y,Z,V,-20:20:105,0,0);
% colorbar
% xlabel('x');
% ylabel('y');
% zlabel('z');
% title('Potential');
% Generates a 3D plot of slices of equipotential surfaces for a smaller
% region focused around the actual quadrupole.

% figure(3);
% [X,Y,Z] = meshgrid(43,-8:0.1:8,-8:0.1:8);
% V = interpolateSolution(result,X,Y,Z);
% V = reshape(V,size(X));
% y = reshape(Y,[161,161]);
% z = reshape(Z,[161,161]);
% v = reshape(V,[161,161]);
% surf(y,z,v);
% zlabel('Potential (V)');
% title('Radial Potential');

% figure(4);
% [X,Y,Z] = meshgrid(41.9:0.05:43.9,0,0);
% V = interpolateSolution(result,X,Y,Z);
% V = reshape(V,size(X));
% plot(X,V);
% hold on
% ylabel('Potential (V)');
% xlabel('z');
% 
% p = polyfit(X,V,2);
% y = polyval(p,X);
% plot(X,y);
% 
% axFreq = calcApproxFreq(p(1));
% AxialFrequency = sprintf('%0.3e',axFreq);
% title(strcat('Axial Potential:  ',AxialFrequency,' kHz'));

% figure(5);
% plot(X,y-V);

% title('Error');

end

% FinalPaul Faces: 60
%   Outer Boundaries: 1:6
%   Lower RF: 22:33  
%   Upper RF: 34:45
%   DC layout:
%
%   =======     =======     =======     =======     =======
%   =19:21=     = 7:9 =     =10:12=     =16:18=     =13:15=
%   =======     =======     =======     =======     =======
%
%
%   =======     =======     =======     =======     =======
%   =46:48=     =49:51=     =52:54=     =55:57=     =58:60=
%   =======     =======     =======     =======     =======
%     ^           ^           ^           ^           ^
%     |           |           |           |           |
%    i=1         i=2         i=3         i=4         i=5
%
%   2 RF rods (not shown): i=6
%
%       Looking at the model from view(0,0)




