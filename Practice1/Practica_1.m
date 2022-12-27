%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ASSIGNMENT 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Made by ANTONIO DELGADO BEJARANO.
%% 1.- Intrinsic parameters of the camera: 
f = 0.0042;             % Focal distance. 
N = 4128;               % Image width in pixels.
M = 3096;               % Image high in pixels.
anchoSensor = 0.00496;  % Sensor width in meters.
altoSensor  = 0.00352;  % Sensor high in meters.
rho_x = anchoSensor/N;
rho_y = altoSensor/M;
fx = f/rho_x;
fy = f/rho_y;
s = 0;                  % Skew

% Main point of the image (with the requested deviation):
u0 = round(N/2) + 1;
v0 = round(M/2) - 2;

% Matrix of intrinsic parameters:
A = [ fx  s*fx   u0
       0    fy   v0
       0     0    1 ];
   
%% 2.- Object definition

% We ask the user to enter the dimensions of the object (the number
% of rows and columns) and the separation in mm of the points of each row 
% and of each column:

disp('Define the dimensions of the flat object in the W (world) system');
x = input('\nNumber of columns: ');
tamx = input('Separation between the columns in mm: ');
y = input('Number of rows: ');
tamy = input('Separation between the rows in mm: ');
z = input('Position relative to the Z axis:');

W = creaObjeto(x,y,tamx,tamy,z); %Call function to create the object

%% 3.- Position and relative orientation of {C} with respect to {W}:

% Position of the origin of {C} with respect to the system {W}:
x_d = 0; y_d = 0.05; z_d = 0.5;
wtc = [x_d,y_d,z_d]'; % Translation vector. 

% Orientation of {C} with respect to the system {W}:
psi   = pi;       % Rotation angle about Z axis.
theta = 0;        % Rotation angle about Y axis.
phi   = pi;       % Rotation angle about X axis..

% Rotation matrix (wRc) given by three turns. ZYX mobile axes convention:
Rz = [ cos(psi) -sin(psi) 0
       sin(psi)  cos(psi) 0
           0         0    1 ];
      
Ry = [ cos(theta) 0 sin(theta)
           0      1    0
      -sin(theta) 0 cos(theta) ];           

Rx = [ 1    0        0
       0 cos(phi) -sin(phi) 
       0 sin(phi)  cos(phi) ];

wRc = Rz*Ry*Rx; %Rotation matrix.

% Matrix of the transformation. We include rotation and displacement:
wTc = [wRc wtc; [0 0 0 1]]; 

% Inverse matrix of the transformation:
cTw = [wRc', -wRc'*wtc; [0 0 0 1]]; 
cRw = cTw(1:3,1:3);
ctw = cTw(1:3,4);

%% 4.- 3D scheme

% We build the axes to have a correct size:
E_x=[W(1,1) W(1,x); W(2,1) W(2,x); W(3,1) W(3,x);1 1];
E_y=[W(1,1) W(1,1);W(2,1) W(2,y*x); W(3,1) W(3,y*x); 1 1];

if z==0
    E_z=[0 0;0 0;0 (z|1); 1 1];   %(z|1) is added to solve z=0 case
else 
    E_z=[0 0;0 0;0 z; 1 1];
end

% We represent the object in 3 dimensions:
figure(1);plot3(W(1,:),W(2,:),W(3,:),'*'); grid;
title('Object and camera positions')
xlabel('X Axis')  %Axis names
ylabel('Y Axis')
zlabel('Z Axis')

hold on;

% Representation of the X,Y,Z coordinate axes on the same graph as
% the object:
plot3(E_x(1,:),E_x(2,:),E_x(3,:),'r','linewidth',1.5) %X axis in red
plot3(E_y(1,:),E_y(2,:),E_y(3,:),'g','linewidth',1.5) %Y axis in green
plot3(E_z(1,:),E_z(2,:),E_z(3,:),'b','linewidth',1.5) %Z axis in blue

% Camera axes. We divide by 3 to represent them smaller and
% differentiate them well from the previous axes. Same colors as above:

wE_x=wTc*E_x;
wE_y=wTc*E_y;
wE_z=wTc*E_z;

% Representation of the axes of the camera, again on the same graph:
plot3(wE_x(1,:),wE_x(2,:),wE_x(3,:),'k','linewidth',1.5) 
plot3(wE_y(1,:),wE_y(2,:),wE_y(3,:),'c','linewidth',1.5)
plot3(wE_z(1,:),wE_z(2,:),wE_z(3,:),'m','linewidth',1.5)
hold off;

%% 5.- Projection of the object in the image with and without distortion:

% We add a column of ones to pass it to homogeneous coordinates:
W_ = [W; ones(1,size(W,2))]; 

% We apply the matrix A and the transformation to the object in homogeneous
% coordinates:
w_ = A * [cRw ctw] * W_;    

% Following the definition of homogeneous, we divide by the third row:
w = w_(1:2,:)./w_(3,:);
   
% It is rounded to obtain a specific pixel:
w = round (w);     
 
% We represent the projection of the object:
figure(2); plot(w(1,:),w(2,:),'*'); grid;
axis([-50,N+50,-50,M+50]);
hold on; 

% We draw the outer frame of the image in black, considering that the range
% of the columns is [1..N] and the % of the rows is [1..M]:
plot([0,0,N+1,N+1,0],[0,M+1,M+1,0,0],'Color','k', 'LineWidth',2);

% Representation of the coordinate axes:
plot([w(1,1) w(1,x)], [w(2,1) w(2,x)],'g','linewidth',1.5)
plot([w(1,1) w(1,1)], [w(2,1) w(2,y*x)],'b','linewidth',1.5)

% We invert the direction of the y-axis, as usual:
set(gca,'YDir', 'reverse'); 
pause

% CALCULATION WITH DISTORTION:

% Radial distortion coefficients:
k_r1 = 0.144;
k_r2 = -0.307;

% Tangential distortion coefficients:
k_t1 = -0.0032;
k_t2 =  0.0017;

% Projection matrix
K = [ f 0 0 0
      0 f 0 0 
      0 0 1 0]; 
 
mp_ = K*cTw*W_;  
mp = mp_(1:2,:)./mp_(3,:);

% Matrix of zeros that we are going to fill in next:
mpDist = zeros(size(mp));

for i=1:size(W,2)
   
   % Radial distortion calculation.
   pNorm = mp(:,i)/f;    
   r = norm(pNorm);
   deltaR = 1 + k_r1*r^2 + k_r2*r^4;
   
   % Tangential distortion calculation.
   deltaTx = 2*k_t1*pNorm(1,1)*pNorm(2,1) + k_t2*(r^2+2*pNorm(1,1)^2);
   deltaTy = 2*k_t2*pNorm(1,1)*pNorm(2,1) + k_t1*(r^2+2*pNorm(2,1)^2);
   
   % We calculate the coordinates of the distorted point:
   x_dist = pNorm(1,1) * deltaR  + deltaTx;
   y_dist = pNorm(2,1) * deltaR  + deltaTy;
   
   % We calculate each distorted pixel:
   u = x_dist*fx + u0;
   v = y_dist*fy + v0;
   mpDist(1,i) = u;
   mpDist(2,i) = v;

end

% Finally we represent the distorted point:
figure(2)
plot (mpDist(1,:),mpDist(2,:),'*','Color','r');
hold off;
