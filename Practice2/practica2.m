%%%%%%%%%%%%%%%%%%%% PRACTICE 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%

addpath('TOOLBOX_calib')

%% 1.- Parametros intrinsecos de la camara: 

fx= round(3202.14439);
fy= round(3199.25500);
fc = [fx fy];           % Vector distancia focal. 
alpha_c = 0;            % Skew

% Punto principal de la imagen (con la desviaci?n pedida):
u0 = round(1963.41894);
v0 = round(1459.85733);
cc=[u0 v0];

%Vector de distorsion
kc=[0.17021 -0.44377 -0.00413 -0.00161 0.00000];

% Matriz de parametros intrinsecos:
A = [ fx  alpha_c*fx   u0
       0    fy   v0
       0     0    1 ];
%% Estimacion posicion objeto de referencia

[~, cto,cRo,~]=compute_extrinsic(centers',[centers';zeros(1,size(centers,1))],fc, cc, kc, alpha_c)


%wTc = [cRo cto; [0 0 0 1]]; 
%cTw = [cRo', -cRo'*cto; [0 0 0 1]]; 
%cRw = cTw(1:3,1:3);
%ctw = cTw(1:3,4);

%% Definicion del objeto respecto a la referencia

x=1000;y=1000;a=600;b=600; %en mm
T= creaTronoVirtual(x,y,a,b);

% Add una columna de unos para pasarlo a coordenadas homogeneas:
T_ = [T; ones(1,size(T,2))];
% Aplicamos la matriz A y la transformacion al objeto en homogeneas:
t_ = A * [cRo cto] * T_;

% Atendiendo a la definicion de homogeneas dividimos por la tercera fila:
t = t_(1:2,:)./t_(3,:);
   
% Se redondea para obtener un p?xel concreto:
t = round (t);

figure(1),
imshow(I,[]),hold on; %plot(T,'*'),hold off %representa sobre imshow


%Representacion del objeto
%Se separa T en los puntos que definen cada parte
B_i=t(:,1:4);
B_s=t(:,5:8);
R=t(:,9:10);
%Base inferior
plot([B_i(1,:) B_i(1,1)],[B_i(2,:) B_i(2,1)],'r')
%Base superior
%plot([B_s(1,:) B_s(1,1)],[B_s(2,:) B_s(2,1)],'r')
% %Respaldo
%plot(R(1,:), R(2,:),'r')
%Unimos las bases
plot([B_i(1,1) B_s(1,1)],[B_i(2,1) B_s(2,1)],'b')
plot([B_i(1,2) B_s(1,2)],[B_i(2,2) B_s(2,2)],'b')
plot([B_i(1,3) B_s(1,3)],[B_i(2,3) B_s(2,3)],'b')
plot([B_i(1,4) B_s(1,4)],[B_i(2,4) B_s(2,4)],'b')
%Unimos el respaldo y el asiento
%plot([B_s(1,1) R(1,1)],[B_s(2,1) R(2,1)],'b')
%plot([B_s(1,4) R(1,2)],[B_s(2,4) R(2,2)],'b')
hold off
