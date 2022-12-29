function s=ContrastStretching(r, r1, s1, r2,s2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Funcion ContrastStretching que realiza una tabla de transformacion lineal
% a trozos para un histograma. Por debajo del nivel r1 se transforma segun
% s1; y por encima de r2 se transforma segun s2 hasta 255. El segundo tramo
% es una transformaci?n lineal entre r1-r2, seg?n s1-s2. La transformacion 
% es en tres trozos.
%
% Parametros de entrada:
% . r : rango dinamico original de la imagen.
% . r1: rango dinamico original. Valor inicial del segundo tramo de la 
%       transformacion 
% . s1: rango dinamico nuevo. Valor inicial del segundo tramo de la
%       transformacion
% . r2: rango dinamico original. Valor final del segundo tramo de la 
%       transformacion 
% . s2: rango dinamico nuevo. Valor final del segundo tramo de la
%       transformacion
% Parametros de salida:
% . s: rango dinamico resultante de la transformacion lineal
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %Primer tramo. Por debajo de r1
    if r<=r1
        s0=0;r0=0;m=(s1-s0)/(r1-r0);
    %Tercer tramo. Por encima de r2
    elseif r>=r2
        s0=s2;r0=r2;m=(255-s0)/(255-r0);
    %Segundo tramo. Entre r1 y r2
    else
        s0=s1;r0=r1;m=(s2-s0)/(r2-r0);
    end
    
    %Ecuacion punto-pendiente de la transformaci?n
    s=uint8(s0+m*(r-r0));
    
end