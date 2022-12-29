%%%%%%%%%%%%%%%%%%%%%%%         PRACTICA 3            %%%%%%%%%%%%%%%%%%%%%

clear all
close all

%% 1. Lectura y filtrado

%Lectura y conversion a escala de grises:
I=im2double(imread('monedasLlaves.jpg'));I=rgb2gray(I);

figure(1), title(strcat('Imagen monedasLlaves')), imshow(I), shg

%Filtro de mediana:
I_Mediana=uint8(255*medfilt2(I,[5 5]));
%I_mediana=FiltroMediana(I, radioMask);
figure(2), title(strcat('Imagen monedasLlaves filtrada')),...
    imshow(I_Mediana), shg

input('Pulse cualquier tecla para continuar')

%Expasion de contraste mediante analisis de histograma:
I_MayorContraste=ExpansionContraste(I_Mediana,8);

figure(3), title(strcat('Imagen monedasLlaves MayorContraste')),...
    imshow(I_MayorContraste), shg

%% Binarizacion de la imagen

%Obetenemos el histograma:
[counts, ~]=imhist(I_MayorContraste);

%Calculamos el umbral de Otsu:
umbral= CalculaUmbralOtsu(counts);

%Binarizacion de la imagen y representacion de la imagen binarizada:
I_binarize=(I_MayorContraste<=umbral); figure(4), imshow(I_binarize)

%% Morfologia para mejora de la imagen de siluetas

%Mascara para cierre y funcion de cierre:
seC=strel('disk',22);
I_closed=cierre(I_binarize,seC); figure(5), imshow(I_closed)

%Mascara para apertura y funcion de apertura:
seO=strel('disk',25);
I_opened=apertura(I_closed,seO); figure(6), imshow(I_opened)

%Obtencion del BoundingBox con regionprops:
stats=regionprops(I_opened, 'BoundingBox');

%Obtencion de los parametros de interes con calculaPropGeom:
[props,obj]=calculaPropGeom(I_opened,'Area','Centro','Orientacion', 'Circularidad',...
    'Perimetro');

%Identificamos el tipo de cada objeto (moneda u otro):
[props,id_monedas] = indicaTipo(props);

%Identificamos el tamano de cada moneda (grande, mediana o pequena):
props = indicaTamanio(props,id_monedas);

%Obtenemos el eje mayor de los objetos para representarlo
Eje_Mayor=regionprops('table',obj,'MajorAxisLength');


%% Representacion

%Funcion de etiquetado para poner los nombres o lineas a cada objeto:
title = Etiquetado(I,props);

%Representacion del rectangulo (BoundingBox) de cada objeto:
imshow(title),hold on
for i=1:length(props)
    
% Segun el tamano de cada moneda le asigna un color al rectangulo. Para los
% objetos que no son monedas se aplica el color verde:
if (props(i).Tamanio == 1) 
    rectangle('Position',stats(i).BoundingBox,'EdgeColor','y');
   
elseif (props(i).Tamanio == 2)
    rectangle('Position',stats(i).BoundingBox,'EdgeColor','m');
    
elseif (props(i).Tamanio == 3)
    rectangle('Position',stats(i).BoundingBox,'EdgeColor','r');
    
else
    rectangle('Position',stats(i).BoundingBox,'EdgeColor','g');
    
end  

end 

hold off



