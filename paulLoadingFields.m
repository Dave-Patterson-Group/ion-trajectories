function result = paulLoadingFields(i)
if nargin < 1
    i = 0;
end

model = createpde();
importGeometry(model,'/home/luca/Desktop/Patterson_Group_Projects/PDEs/STLs/FullLoadingPaul.stl');


% figure;
% pdegplot(model,'FaceLabels','on','FaceAlpha',0.15);
% xlabel('x');
% ylabel('y');
% zlabel('z');
% title('Geometry of system');

if i == 1
    applyBoundaryCondition(model,'dirichlet','face',1:6,'u',0); % Ground Boundaries
    
    applyBoundaryCondition(model,'dirichlet','face',[34:36, 19:21],'u',0); % RF

    applyBoundaryCondition(model,'dirichlet','face',[7:9, 10:12, 28:30, 31:33],'u',1); % Far left DC
    applyBoundaryCondition(model,'dirichlet','face',[13:15, 46:48],'u',0); % Left DC
    applyBoundaryCondition(model,'dirichlet','face',[25:27, 43:45],'u',0); % Middle DC
    applyBoundaryCondition(model,'dirichlet','face',[22:24, 40:42],'u',0); % Right DC
    applyBoundaryCondition(model,'dirichlet','face',[16:18, 37:39],'u',0); % Far Right DC
elseif i == 2
    applyBoundaryCondition(model,'dirichlet','face',1:6,'u',0); % Ground Boundaries
    
    applyBoundaryCondition(model,'dirichlet','face',[34:36, 19:21],'u',0); % RF

    applyBoundaryCondition(model,'dirichlet','face',[7:9, 10:12, 28:30, 31:33],'u',0); % Far left DC
    applyBoundaryCondition(model,'dirichlet','face',[13:15, 46:48],'u',1); % Left DC
    applyBoundaryCondition(model,'dirichlet','face',[25:27, 43:45],'u',0); % Middle DC
    applyBoundaryCondition(model,'dirichlet','face',[22:24, 40:42],'u',0); % Right DC
    applyBoundaryCondition(model,'dirichlet','face',[16:18, 37:39],'u',0); % Far Right DC
elseif i == 3
    applyBoundaryCondition(model,'dirichlet','face',1:6,'u',0); % Ground Boundaries
    
    applyBoundaryCondition(model,'dirichlet','face',[34:36, 19:21],'u',0); % RF

    applyBoundaryCondition(model,'dirichlet','face',[7:9, 10:12, 28:30, 31:33],'u',0); % Far left DC
    applyBoundaryCondition(model,'dirichlet','face',[13:15, 46:48],'u',0); % Left DC
    applyBoundaryCondition(model,'dirichlet','face',[25:27, 43:45],'u',1); % Middle DC
    applyBoundaryCondition(model,'dirichlet','face',[22:24, 40:42],'u',0); % Right DC
    applyBoundaryCondition(model,'dirichlet','face',[16:18, 37:39],'u',0); % Far Right DC
elseif i == 4
    applyBoundaryCondition(model,'dirichlet','face',1:6,'u',0); % Ground Boundaries
    
    applyBoundaryCondition(model,'dirichlet','face',[34:36, 19:21],'u',0); % RF

    applyBoundaryCondition(model,'dirichlet','face',[7:9, 10:12, 28:30, 31:33],'u',0); % Far left DC
    applyBoundaryCondition(model,'dirichlet','face',[13:15, 46:48],'u',0); % Left DC
    applyBoundaryCondition(model,'dirichlet','face',[25:27, 43:45],'u',0); % Middle DC
    applyBoundaryCondition(model,'dirichlet','face',[22:24, 40:42],'u',1); % Right DC
    applyBoundaryCondition(model,'dirichlet','face',[16:18, 37:39],'u',0); % Far Right DC
elseif i == 5
    applyBoundaryCondition(model,'dirichlet','face',1:6,'u',0); % Ground Boundaries
    
    applyBoundaryCondition(model,'dirichlet','face',[34:36, 19:21],'u',0); % RF

    applyBoundaryCondition(model,'dirichlet','face',[7:9, 10:12, 28:30, 31:33],'u',0); % Far left DC
    applyBoundaryCondition(model,'dirichlet','face',[13:15, 46:48],'u',0); % Left DC
    applyBoundaryCondition(model,'dirichlet','face',[25:27, 43:45],'u',0); % Middle DC
    applyBoundaryCondition(model,'dirichlet','face',[22:24, 40:42],'u',0); % Right DC
    applyBoundaryCondition(model,'dirichlet','face',[16:18, 37:39],'u',1); % Far Right DC
elseif i == 6
    applyBoundaryCondition(model,'dirichlet','face',1:6,'u',0); % Ground Boundaries
    
    applyBoundaryCondition(model,'dirichlet','face',[34:36, 19:21],'u',1); % RF

    applyBoundaryCondition(model,'dirichlet','face',[7:9, 10:12, 28:30, 31:33],'u',0); % Far left DC
    applyBoundaryCondition(model,'dirichlet','face',[13:15, 46:48],'u',0); % Left DC
    applyBoundaryCondition(model,'dirichlet','face',[25:27, 43:45],'u',0); % Middle DC
    applyBoundaryCondition(model,'dirichlet','face',[22:24, 40:42],'u',0); % Right DC
    applyBoundaryCondition(model,'dirichlet','face',[16:18, 37:39],'u',0); % Far Right DC

end

specifyCoefficients(model,'m',0,'d',0,'c',1,'a',0,'f',0);
%Laplace's equation: https://www.mathworks.com/help/pde/ug/equations-you-can-solve.html

generateMesh(model,'hmax',0.8);
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
%

% LongPaul Faces: 48   NO LONGER ACCURATE
%   Outer Boundaries: 1:6
%   Lower RF: 22:27   
%   Upper RF: 28:33
%   DC layout:
%
%   =======     =======     =======     =======     =======
%   =19:21=     = 7:9 =     =10:12=     =16:18=     =13:15=
%   =======     =======     =======     =======     =======
%
%
%   =======     =======     =======     =======     =======
%   =34:36=     =37:39=     =40:42=     =43:45=     =46:48=
%   =======     =======     =======     =======     =======
%


% LongTubePaul Faces: 46
%   Outer Boundaries: 1:6
%   Lower RF: 40:42
%   Upper RF: 22:24  
%   DC layout:
%
%   =======     =======     =======     =======     =======
%   =16:18=     = 7:9 =     =13:15=     =10:12=     =19:21=
%   =======     =======     =======     =======     =======
%
% =43:46=
%   =======     =======     =======     =======     =======
%   =31:33=     =34:36=     =28:30=     =25:27=     =37:39=
%   =======     =======     =======     =======     =======
%


% SidePaul Faces: 60
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
%

% ReflectPaul Faces: 66
%   Outer Boundaries: 1:6
%   Lower RF: 22:33
%   Upper RF: 49:60
%   DC layout:
%
%   =======     =======     =======     =======     =======
%   =16:18=     = 7:9 =     =13:15=     =10:12=     =19:21=
%   =======     =======     =======     =======     =======
%
%
%   =======     =======     =======     =======     =======
%   =40:42=     =43:45=     =37:39=     =34:36=     =46:48=
%   =======     =======     =======     =======     =======
%
%               =61:66=                                       

% ReflectCylPaul Faces: 63
%   Outer Boundaries: 1:6
%   Lower RF: 22:33
%   Upper RF: 52:63
%   DC layout:
%
%   =======     =======     =======     =======     =======
%   =16:18=     = 7:9 =     =13:15=     =10:12=     =19:21=
%   =======     =======     =======     =======     =======
%
%
%   =======     =======     =======     =======     =======
%   =43:45=     =46:48=     =40:42=     =37:39=     =49:51=
%   =======     =======     =======     =======     =======
%
%               =34:36=                                       

% ReflectRingPaul Faces: 63
%   Outer Boundaries: 1:6
%   Lower RF: 22:33
%   Upper RF: 49:60
%   DC layout:    ===
%               =61:64=                                                               
%                 ===
%   =======     =======     =======     =======     =======
%   =16:18=     = 7:9 =     =13:15=     =10:12=     =19:21=
%   =======     =======     =======     =======     =======
%
%
%   =======     =======     =======     =======     =======
%   =40:42=     =43:45=     =37:39=     =34:36=     =46:48=
%   =======     =======     =======     =======     =======
%

% ReflectRingCylPaul Faces: 67
%   Outer Boundaries: 1:6
%   Lower RF: 38:49
%   Upper RF: 53:64
%   DC layout:    ===
%               =28:31=                                                               
%                 ===
%   =======     =======     =======     =======     =======
%   =32:34=     =25:27=     =10:12=     = 7:9 =     =35:37=
%   =======     =======     =======     =======     =======
%
%
%   =======     =======     =======     =======     =======
%   =50:52=     =16:18=     =19:21=     =13:15=     =65:67=
%   =======     =======     =======     =======     =======
%
%               =22:24=

% ReflectTubeCylPaul Faces: 67
%   Outer Boundaries: 1:6
%   Lower RF: 25:36
%   Upper RF: 52:63
%   DC layout:    ===
%               = === =
%               =64:67=                                                               
%                 ===
%   =======     =======     =======     =======     =======
%   =13:15=     =16:18=     =10:12=     = 7:9 =     =22:24=
%   =======     =======     =======     =======     =======
%
%
%   =======     =======     =======     =======     =======
%   =37:39=     =40:42=     =46:48=     =43:45=     =49:51=
%   =======     =======     =======     =======     =======
%
%               =19:21=

% EndCapPaul Faces
%   Outer Boundaries: 1:6
%   Lower RF: 34:36
%   Upper RF: 19:21
%   DC layout:   
%               
%   =======     =======     =======     =======     =======
%   = 7:9 =     =13:15=     =25:27=     =22:24=     =16:18=
%   =10:12=     =======     =======     =======     =======
%   =======
%   =======
%   =31:33=     =======     =======     =======     =======
%   =28:30=     =46:48=     =43:45=     =40:42=     =37:39=
%   =======     =======     =======     =======     =======
%
%    
