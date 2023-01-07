%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %  
%  Clasificador de minima distancia para piezas de tetris                 %
%  Programa principal                                                     %
%  Antonio Delgado Bejarano                                               %
%                                                                         %  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Limpiamos...
close all
clear all
clc

% Leemos los archivos CEt:
imagenes_CEt=['CEt401.png';'CEt402.png';'CEt403.png';'CEt404.png';
    'CEt405.png';'CEt406.png';'CEt407.png';'CEt408.png';'CEt409.png';];

% Contamos los archivos leidos:
[Num_arc,~]=size(imagenes_CEt); 

% Matriz de caracteristicas para cada imagen que posteriormente
% rellenaremos:
M=zeros(2, Num_arc);

% Bucle para recorrer todas las imagenes:
for k=1:Num_arc
    
    % Carga la imagen:
    Pieza_k = imread(imagenes_CEt(k,:));
    
    % Calculamos el vector de caracteristicas de dicha imagen:
    calculo_vector_caract;
    
    % Almacenamos el vector de caracteristicas de cada imagen en M:
    M(:,k)=x;
end

% Imprimimos por la Command Window la descripcion de las variables 
% componentes del vector de caracteristicas:
fprintf('\nEl vector de caracteristicas usado para el CE es: [mu43/m11; mu34/m11]\n');
fprintf('donde m11 es el momento de orden 1, mu43 es igual a m43 - m12^2/m11 y\n');
fprintf('mu34 es igual a m34 - m21^2/m11\n');
% Clases correctas de cada objeto introducidas a mano:
C = [ 1 1 1 2 2 2 3 3 3 ];

% Calculamos los prototipos del CE:
[ Nx, Nelem] = size(M);
suma = zeros(Nx, 3); 
z = zeros(Nx,3);
cont = zeros(1, 3);

for j=1:Nelem
    claseactual = C(1,j);
    vectoactual = M(:,j);
    suma(:,claseactual) = suma(:,claseactual) + vectoactual;
    cont(1,claseactual) = cont(1,claseactual) + 1;
end

% Almacenamos en z cada prototipo:
for clase=1:3
    z(:,clase) = suma(:,clase)/cont(1,clase);
end

% Imprimimos por la Command Window los tres vectores prototipo:
fprintf('\nLos tres vectores prototipo del CE son:\n(%f, %f)\n(%f, %f)\n(%f, %f) \n', ...
z(1,1),z(2,1),z(1,2),z(2,2),z(1,3),z(2,3));

% Clasificador con los datos del CE:

% Contador para ir almacenando los datos:
cont_fallos = 0;

% Clasificamos los datos:

% Recorremos con un bucle todos los elementos:
for j=1:Nelem
    
    % xo considerado:
    xo = M( :,j);
    
    % Clasificacion del xo:
    for clase=1:3
        % Diferencia entre el xo considerado y el prototipo:
        vdife = xo - z(:, clase);
        % Calculamos la distancia:
        d(1,clase) = sqrt(sum(vdife.^2));
    end
    % Escogemos el minimo pues es un clasificador de minima distancia:
    [valormin, claseasig] = min(d);
    
    % Si la clase calculada es diferente a la que sabemos que debiamos
    % obtener, incrementamos el contador de fallos:
    if claseasig ~= C(1,j)
        cont_fallos = cont_fallos + 1;
    end
end

% Imprimimos por la Command Window el PCI del CE:
fprintf('\n Para el conjunto de imagenes CE, PCI = %f (%%) \n', ...
100*cont_fallos/Nelem);


% Ahora hacemos lo mismo para los archivos CPt:

% Leemos los archivos CPt:
imagenes_CPt=['CPt401.png';'CPt402.png';'CPt403.png';'CPt404.png';
    'CPt405.png';'CPt406.png';'CPt407.png';];

% Contamos los archivos leidos:
[Num_arc,~]=size(imagenes_CPt);

% Matriz de caracteristicas para cada imagen que posteriormente
% rellenaremos:
M=zeros(2, Num_arc);

% Bucle para recorrer todas las imagenes:
for k=1:Num_arc
   
    % Carga la imagen:
    Pieza_k=imread(imagenes_CPt(k,:));
    
    % Calculamos el vector de caracteristicas de dicha imagen:
    calculo_vector_caract;
    
    % Almacenamos el vector de caracteristicas de cada imagen en M:
    M(:,k)=x;
end

% Imprimimos por la Command Window la descripcion de las variables 
% componentes del vector de caracteristicas:
fprintf('\nEl vector de caracteristicas usado para el CP es: [mu43/m11; mu34/m11]\n');
fprintf('donde m11 es el momento de orden 1, mu43 es = a m43 - m12^2/m11 y\n');
fprintf('mu34 es = a m34 - m21^2/m11\n');

% Clases correctas de cada objeto introducidas a mano:
C = [ 1 1 1 2 2 3 3];

% Calculamos los prototipos del CP:
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

% Almacenamos en z cada prototipo:
for clase=1:3
    z( :,clase) = suma(:,clase)/cont(1,clase);
end

% Imprimimos por la Command Window los tres vectores prototipo:
fprintf('\nLos tres vectores prototipo del CP son:\n(%f, %f)\n(%f, %f)\n(%f, %f) \n', ...
z(1,1),z(2,1),z(1,2),z(2,2),z(1,3),z(2,3));


% Clasificador para los datos del CP:

% Contador para ir almacenando los datos:
cont_fallos = 0;

% Recorremos con un bucle todos los elementos:
for j=1:Nelem
    
    % xo considerado:
    xo = M( :,j);
    
    % Clasificacion del xo:
    for clase=1:3
        % Diferencia entre el xo considerado y el prototipo:
        vdife = xo - z( :, clase);
        % Calculamos la distancia:
        d( 1,clase) = sqrt(  sum(  vdife.^2  ) );
    end
    % Escogemos el minimo pues es un clasificador de minima distancia:
    [ valormin, claseasig] = min( d);
    
    % Si la clase calculada es diferente a la que sabemos que debiamos
    % obtener, incrementamos el contador de fallos:
    if claseasig ~= C(1,j)
        cont_fallos = cont_fallos + 1;
    end
end

% Imprimimos por la Command Window el PCI del CP:
fprintf('\n Para el conjunto de imagenes CP, PCI = %f (%%) \n', ...
100*cont_fallos/Nelem);