%%%%%%%%%%%%% Clasificador minima distancia piezas tetris %%%%%%%%%%%%%%%%%

% Limpiamos:
close all
clear
clc

% Leemos las fotografias de las piezas CEt:
piezas_CEt=['CEt401.png';'CEt402.png';'CEt403.png';'CEt404.png';
    'CEt405.png';'CEt406.png';'CEt407.png';'CEt408.png';'CEt409.png';];

% Numero de fotografias leidas:
[Num_piezas,~]=size(piezas_CEt); 

% Matriz de caracteristicas que rellenaremos en el bucle siguiente:
M=zeros(2, Num_piezas);

% Recorremos todas las imagenes CEt:
for i=1:Num_piezas
   
    %Cargamos la imagen:
    f=imread(piezas_CEt(i,:));
    
    %Calculamos el vector de caracteristicas de dicha imagen:
    m_vectorx_nuevo;
    
    %Almacenamos el vector de caracteristicas de cada imagen en M:
    M(:,i)=x;
    
end

% Clase correcta de cada imagen a ojo:
Clases_Correctas = [ 1 1 1 2 2 2 3 3 3 ];

% Calculamos los prototipos:
[ Nx, Nelem] = size(M);
suma = zeros( Nx, 3); 
z = zeros(Nx,3);
cont = zeros( 1, 3);
for j=1:Nelem
    claseactual = Clases_Correctas( 1,j);
    vectoactual = M( :,j);
    suma( :,claseactual) = suma( :,claseactual) + vectoactual;
    cont( 1,claseactual) = cont( 1,claseactual) + 1;
end



for clase=1:3
    z( :,clase) = suma(:,clase)/cont(1,clase);
end

%% Representacion M caso CE

% Representamos M
figure
hold on
plot(M(1, 1:3), M(2, 1:3), 'rx');
plot(M(1, 4:6), M(2, 4:6), 'go');
plot(M(1, 7:9), M(2, 7:9), 'bs');
grid
xlabel('x1');
ylabel('x2');

%% Uso del clasificador con los datos del CE

cont_fallos = 0;
%figure; hold on
% clasificacion exhaustiva de los datos suministrados
for j=1:Nelem
    
    % xo considerado
    xo = M( :,j);
    
    % clasificacion del xo
    for clase=1:3
        vdife = xo - z( :, clase);
        d( 1,clase) = sqrt(  sum(  vdife.^2  ) );
    end
    [ valormin, claseasig] = min( d);
    % comprobacion de la clasificacion realizada
    if claseasig ~= Clases_Correctas(1,j)
        cont_fallos = cont_fallos + 1;
    end
end
fprintf('\n Para el conjunto de imagenes CE, PCI = %f (%%) \n', ...
100*cont_fallos/Nelem);

return

%% Archivos P
nomb_arch_CP=['CPt401.png';
    'CPt402.png';
    'CPt403.png';
    'CPt404.png';
    'CPt405.png';
    'CPt406.png';
    'CPt407.png';];
lista=nomb_arch_CP;
[Narch,~]=size(lista); %Numero de archivos en la lista
M=zeros(2, Narch); %Matriz de caracteristicas para cada archivo
for ar=1:Narch
    %Carga imagen
    f=imread(lista(ar,:));
    %Calculo de x=(mu20/m00, m02/m00)' para la imagen actual
    m_vectorx;
    %Almacenamiento en matrices para uso posterior
    M(:,ar)=x;
end

%Vector conteniendo las clases correctas (a mano)
C = [ 1 1 1 2 2 2 3 3 3 ];

% calcular los prototipos
[ Nx, Nelem] = size(M);
suma = zeros( Nx, 3); 
z = zeros(Nx,3);
cont = zeros( 1, 3);
for j=1:Nelem
    claseactual = C( 1,j);
    vectoactual = M( :,j);
    suma( :,claseactual) = suma( :,claseactual) + vectoactual;
    cont( 1,claseactual) = cont( 1,claseactual) + 1;
end
for clase=1:3
    z( :,clase) = suma(:,clase)/cont(1,clase);
end

%% Representacion M caso CP

% Representamos M
figure
hold on
plot(M(1, 1:3), M(2, 1:3), 'rx');
plot(M(1, 4:5), M(2, 4:5), 'go');
plot(M(1, 6:7), M(2, 6:7), 'bs');
grid
xlabel('x1');
ylabel('x2');

%% Uso del clasificador con los datos del CE

cont_fallos = 0;
%figure; hold on
% clasificacion exhaustiva de los datos suministrados
for j=1:Nelem
    
    % xo considerado
    xo = M( :,j);
    
    % clasificacion del xo
    for clase=1:3
        vdife = xo - z( :, clase);
        d( 1,clase) = sqrt(  sum(  vdife.^2  ) );
    end
    [ valormin, claseasig] = min( d);
    % comprobacion de la clasificacion realizada
    if claseasig ~= C(1,j)
        cont_fallos = cont_fallos + 1;
    end
end
fprintf('\n Para el conjunto de imagenes CP, PCI = %f (%%) \n', ...
100*cont_fallos/Nelem);