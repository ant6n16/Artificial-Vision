%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %  
%  Clasificador de minima distancia para piezas de tetris                 %
%  Funcion para calcular el vector de caracteristicas                     %
%  Antonio Delgado Bejarano                                               %
%                                                                         %  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

umbral = 20;
o = double( Pieza_k > umbral);
[Nfil,Ncol] = size(o);

%m11
p=1; q=1;
mpq=0;
for i=1:Nfil
    for j=1:Ncol
        mpq= mpq + i^p*j^q*o(i,j);
    end
end
m11=mpq;

%m21
p=2; q=1;
mpq=0;
for i=1:Nfil
    for j=1:Ncol
        mpq= mpq + i^p*j^q*o(i,j);
    end
end
m21=mpq;

%m12
p=1; q=2;
mpq=0;
for i=1:Nfil
    for j=1:Ncol
        mpq= mpq + i^p*j^q*o(i,j);
    end
end
m12=mpq;

%m43
p=4; q=3;
mpq=0;
for i=1:Nfil
    for j=1:Ncol
        mpq= mpq + i^p*j^q*o(i,j);
    end
end
m43=mpq;

%m34
p=3; q=4;
mpq=0;
for i=1:Nfil
    for j=1:Ncol
        mpq= mpq + i^p*j^q*o(i,j);
    end
end
m34=mpq;

% Momentos utilizados:
mu43= m43 - m12^2/m11;
mu34= m34 - m21^2/m11;

% Vector de caracteristicas:
x=[mu43/m11; mu34/m11];