function fMayorContraste=ExpansionContraste(f,porcentajeResidual)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Funcion ExpansionContraste que toma una imagen y un porcentaje que
% servira de referencia para expandir el histograma de la imagen y aumentar
% el contraste.
%
% Parametros de entrada:
% . f: imagen a tratar
% . porcentajeResidual: entero que representa el tanto por ciento a
% despreciar del histograma por cada uno de los lados del mismo.
%
% Parametros de salida:
% . fMayorContraste: imagen con el histograma expandido.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[M,N]=size(f); Npixels=M*N;

%Obtenemos el histograma de la imagen
[counts, r]=imhist(f);

%Variables auxiliares para comprobar el porcentaje y tomar el nivel de
%intensidad
integral=0; idx=0;

%Se obtiene el nivel de intensidad minimo a tener en cuenta
while(integral<=porcentajeResidual*Npixels/100)
    idx=idx+1;
    integral=cumsum(counts(1:idx));
end

%Valor minimo hasta el cual los nuevos valores de intensidad seran 0
rmin=r(idx);

integral=0; idx=length(counts);

%Se obtiene el nivel de intensidad maximo a tener en cuenta
while(integral<=(porcentajeResidual*Npixels/100))
    integral=cumsum(counts(idx:end));
    idx=idx-1;
end

%Valor maximo a partir del cual los nuevos valores de intensidad seran 255
rmax=r(idx);

%Se hace uso de la funcion contrasStretching para obtener la lut de
%transformacion lineal a trozos
lut=ContrastStretching(r,rmin,0,rmax,255);

%Aumentamos el contraste haciendo uso de la lut
fMayorContraste=lut(f+1);

end