function umbral = CalculaUmbralOtsu (h)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Funcion CalculaUmbralOtsu que el histograma de una imagen y calcula un 
% umbral para binarizar la imagen, segun el m?todo de Otsu.
%
% Parametros de entrada:
% . h: histograma de la imagen como vector que contiene el numero de
% pixeles de cada nivel.
% Parametros de salida:
% . umbral: nivel de gris que separa el histograma en fondo y objeto.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Obtenemos la funcion de probabilidad del histograma
p = double(h)/sum(h);

%Variable auxiliar que almacena la varianza de la funcion p segun el nivel
%de gris que separe las dos funciones del metodo de Otsu.
tabVarIntraclase = zeros(256,1);

%Para cada nivel de gris, se definen dos funciones de probabilidad, y se
%calcula su varianza
for T = 0:255
   indT = T+1;
   %Se calculan las constantes que escalan las dos funciones desde las que
   %se parte en cada iteracion
   A1 = sum(p(1:indT));
   A2 = sum(p(indT+1:256));
   
   %Se calculan la medias de ambas funciones de probabilidad
   mu1 = 0;
   mu2 = 0;
   for r=0:T
      mu1 = mu1 + r*p(r+1);
   end
   for r=T+1:255
      mu2 = mu2 + r*p(r+1);
   end
   
   mu1 = mu1/A1;
   mu2 = mu2/A2;
   
   %Se calculan la varianzas de ambas funciones de probabilidad
   var1 = 0;
   var2 = 0;
   for r=0:T
      var1 = var1 + (r-mu1)^2*p(r+1);
   end
   for r=T+1:255
      var2 = var2 + (r-mu2)^2*p(r+1);
   end
   var1 = var1/A1;
   var2 = var2/A2;
    
   %Tabla de varianza de la funcion p para cada par de funciones segun el
   %nivel de gris
   tabVarIntraclase(indT) = A1*var1+A2*var2;
end

%Obtenemos la posici?n del minimo de la varianza, nivel en el que las
%funciones coinciden
[varMin,indMin] = min(tabVarIntraclase);

%El umbral coincidir? con la posici?n (1:256) de dicho m?nimo transformado 
%a nivel de gris(0:255)
umbral = indMin-1;

end
