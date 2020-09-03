function resultsFullLoading = compileFullLoadingFields()
% Runtime: ~ 20 mins

% results = [resultAccel, resultEinzel, resultGateTop, resultGateBottom, resultFarLeft, resultLeft, resultMiddle, resultRight, resultFarRight, resultRF]

vAccel = 1;
vEinzel = 1;
vGateTop = 1;
vGateBottom = 1;


modelAccel = createpde();
importGeometry(modelAccel,'TOFaccel.stl');

% figure(3);
% pdegplot(modelAccel,'FaceLabels','on','FaceAlpha',0.1);
% xlabel('x');
% ylabel('y');
% zlabel('z');
% title('Geometry of system');
% xlim([-24 24]);
% ylim([-24 24]);
% zlim([-30 420]);
% view(40,0);

%Nonzero voltages
applyBoundaryCondition(modelAccel,'dirichlet','face',22,'u',vAccel); % Back electrode
applyBoundaryCondition(modelAccel,'dirichlet','face',9:11,'u',0); % B electrode


%Ground
applyBoundaryCondition(modelAccel,'dirichlet','face',[13:15, 17, 3, 5, 6, 2, 4, 8],'u',0); % A & Hex, C, Tube, Pinhole, and D

%Insulator
applyBoundaryCondition(modelAccel,'neumann','face',18:20,'q',0,'g',0);


specifyCoefficients(modelAccel,'m',0,'d',0,'c',1,'a',0,'f',0);
%Laplace's equation: https://www.mathworks.com/help/pde/ug/equations-you-can-solve.html

generateMesh(modelAccel,'hmax',1.0);
resultAccel = solvepde(modelAccel);


%------------------------------------------------------------------------------------------%

modelEinzel = createpde();
importGeometry(modelEinzel,'TOFaccel.stl');

%Nonzero voltages
applyBoundaryCondition(modelEinzel,'dirichlet','face',22,'u',0); % Back electrode
applyBoundaryCondition(modelEinzel,'dirichlet','face',9:11,'u',vEinzel); % B electrode


%Ground
applyBoundaryCondition(modelEinzel,'dirichlet','face',[13:15, 17, 3, 5, 6, 2, 4, 8],'u',0); 

%Insulator
applyBoundaryCondition(modelEinzel,'neumann','face',18:20,'q',0,'g',0);


specifyCoefficients(modelEinzel,'m',0,'d',0,'c',1,'a',0,'f',0);
%Laplace's equation: https://www.mathworks.com/help/pde/ug/equations-you-can-solve.html

generateMesh(modelEinzel,'hmax',1.0);
resultEinzel = solvepde(modelEinzel);


%==============================================================================================================%


%Top if you view(90,0) and camroll(-90) to get a side view
modelGateTop = createpde();
importGeometry(modelGateTop,'TOFGateOffset365pt5.stl');

% figure(4);
% pdegplot(modelGateTop,'FaceLabels','on','FaceAlpha',0.1);
% xlabel('x');
% ylabel('y');
% zlabel('z');
% title('Geometry of system');
% xlim([-24 24]);
% ylim([-24 24]);
% zlim([-10 60]);
% view(90,0);

%Nonzero voltages
applyBoundaryCondition(modelGateTop,'dirichlet','face',20:25,'u',vGateTop); % Top Gate Electrode
applyBoundaryCondition(modelGateTop,'dirichlet','face',14:19,'u',0); % Bottom Gate Electrode

%Ground
applyBoundaryCondition(modelGateTop,'dirichlet','face',[11,12, 7:9, 2,4,5],'u',0); 


specifyCoefficients(modelGateTop,'m',0,'d',0,'c',1,'a',0,'f',0);
%Laplace's equation: https://www.mathworks.com/help/pde/ug/equations-you-can-solve.html

generateMesh(modelGateTop,'hmax',0.85);
resultGateTop = solvepde(modelGateTop);

%------------------------------------------------------------------------------------------%

modelGateBottom = createpde();
importGeometry(modelGateBottom,'TOFGateOffset365pt5.stl');

%Nonzero voltages
applyBoundaryCondition(modelGateBottom,'dirichlet','face',20:25,'u',0); % Top Gate electrode
applyBoundaryCondition(modelGateBottom,'dirichlet','face',14:19,'u',vGateBottom); % Bottom Gate electrode

%Ground
applyBoundaryCondition(modelGateBottom,'dirichlet','face',[11,12, 7:9, 2,4,5],'u',0); 


specifyCoefficients(modelGateBottom,'m',0,'d',0,'c',1,'a',0,'f',0);
%Laplace's equation: https://www.mathworks.com/help/pde/ug/equations-you-can-solve.html

generateMesh(modelGateBottom,'hmax',0.85);
resultGateBottom = solvepde(modelGateBottom);

%==============================================================================================================%

resultFarLeft = paulFullLoadingFields(1);
resultLeft = paulFullLoadingFields(2);
resultMiddle = paulFullLoadingFields(3);
resultRight = paulFullLoadingFields(4);
resultFarRight = paulFullLoadingFields(5);
resultRF = paulFullLoadingFields(6);

resultsFullLoading = [resultAccel, resultEinzel, resultGateTop, resultGateBottom, resultFarLeft, resultLeft, resultMiddle, resultRight, resultFarRight, resultRF];

end


%TOFaccel.stl
% Faces:        
%   

%        ===  ===
%        ===  ===
%          =  =
%          =  =
%          =  =     Drift Tube: 2,4,8
%          =  =
%          =  =
%          =  =
%        ===  ===
%        ===  ===

%        ===  ===   Ground C: 3,5,6

%        ===  ===   V_2 B: 9:11
%        ===  ===

%        ===  ===   Ground A & Mesh: 13:15,17 
%        ===  ===
%                   
%        ===  ===
%        =      =   Insulator: 18:20
%        =      =
%        ===  ===
%                       
%        ========
%        ========   Back Electrode: 22
%        ========

%TOFGateOffset365pt5.stl



%        ===  ===   Pinhole 2: 2,4,5
%        ===  ===

%        ========   Gate Top: 20:25
%        ========   Gate Bottom: 14:19

%        ===  ===   Pinhole 1: 7:9

%        ===  ===
%        ===  ===   Drift Tube End: 11,12
%          =  =
