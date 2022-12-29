%Lectura de la imagen
I=imrotate(imread('obj_ref/ref1.jpg'),270); I=uint8(rgb2gray(I));
figure(1), imshow(I)

[umbral,EM]=graythresh(I); Iplantilla=imbinarize(I,umbral);

Ibin=~(255*uint8(Iplantilla));
figure(6), imshow(Ibin),shg, title('Imagen binarizada')

%Eliminamos los espureos
p=strel('rectangle',[3,3]);Iopened=imopen(Ibin,p);
figure(3); imshow (Iopened,[]), shg, title('Imagen binarizada sin espureos')

%Obtenemos las diferentes regiones
stats=regionprops('table',Ibin,'Area','Centroid');
stats=sortrows(stats,1,'descend');
idx=find(stats.Area>1000 & stats.Area<100000);
%Y los centroides para representar posteriormente el objeto
centers=stats.Centroid(idx,:);

%Representamos los centros
figure(4),imshow(I),title('Imagen con Centroides')
hold on
plot(centers(:,1), centers(:,2),'*')
hold off


