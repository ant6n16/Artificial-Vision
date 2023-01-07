
umbral = 20;
o = double( f > umbral);
[Nfil,Ncol] = size(o);

%m00
p=0; q=0;
mpq=0;
for i=1:Nfil
    for j=1:Ncol
        mpq= mpq + i^p*j^q*o(i,j);
    end
end
m00=mpq;

%m10
p=1; q=0;
mpq=0;
for i=1:Nfil
    for j=1:Ncol
        mpq= mpq + i^p*j^q*o(i,j);
    end
end
m10=mpq;

%m01
p=0; q=1;
mpq=0;
for i=1:Nfil
    for j=1:Ncol
        mpq= mpq + i^p*j^q*o(i,j);
    end
end
m01=mpq;

%m20
p=2; q=0;
mpq=0;
for i=1:Nfil
    for j=1:Ncol
        mpq= mpq + i^p*j^q*o(i,j);
    end
end
m20=mpq;

%m02
p=0; q=2;
mpq=0;
for i=1:Nfil
    for j=1:Ncol
        mpq= mpq + i^p*j^q*o(i,j);
    end
end
m02=mpq;

%Momentos centrados
mu20= m20-m10^2/m00;
mu02= m02-m01^2/m00;

%Vector de caracteristicas
x=[mu20/m00; mu02/m00];