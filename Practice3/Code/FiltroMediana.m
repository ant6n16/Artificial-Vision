function fMedian=FiltroMediana(f,radio)

[M,N]=size(f);

% Creamos la mascara segun el radio pasado como parametro:
NpixelsMask=(2*radio+1)^2;

fMedian=zeros(size(f));

% Aplicamos el filtro de mediana:
for i=radio+1:N-radio
    for j=radio+1:M-radio
        fMedian(i,j)=median(reshape(f(i-radio:i+radio,j-radio:j+radio),...
            NpixelsMask,1));
    end
end

% Convertimos el valor a uint8 para devolverlo:
fMedian=uint8(fMedian);

end