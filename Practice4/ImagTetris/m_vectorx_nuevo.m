
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

%m11
p=1; q=1;
mpq=0;
for i=1:Nfil
    for j=1:Ncol
        mpq= mpq + i^p*j^q*o(i,j);
    end
end
m11=mpq;


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


%m30
p=3; q=0;
mpq=0;
for i=1:Nfil
    for j=1:Ncol
        mpq= mpq + i^p*j^q*o(i,j);
    end
end
m30=mpq;

%m03
p=0; q=3;
mpq=0;
for i=1:Nfil
    for j=1:Ncol
        mpq= mpq + i^p*j^q*o(i,j);
    end
end
m03=mpq;

%m31
p=3; q=1;
mpq=0;
for i=1:Nfil
    for j=1:Ncol
        mpq= mpq + i^p*j^q*o(i,j);
    end
end
m31=mpq;

%m13
p=1; q=3;
mpq=0;
for i=1:Nfil
    for j=1:Ncol
        mpq= mpq + i^p*j^q*o(i,j);
    end
end
m13=mpq;

%m22
p=2; q=2;
mpq=0;
for i=1:Nfil
    for j=1:Ncol
        mpq= mpq + i^p*j^q*o(i,j);
    end
end
m22=mpq;


%m32
p=3; q=2;
mpq=0;
for i=1:Nfil
    for j=1:Ncol
        mpq= mpq + i^p*j^q*o(i,j);
    end
end
m32=mpq;

%m23
p=2; q=3;
mpq=0;
for i=1:Nfil
    for j=1:Ncol
        mpq= mpq + i^p*j^q*o(i,j);
    end
end
m23=mpq;

%m33
p=3; q=3;
mpq=0;
for i=1:Nfil
    for j=1:Ncol
        mpq= mpq + i^p*j^q*o(i,j);
    end
end
m33=mpq;

%m40
p=4; q=0;
mpq=0;
for i=1:Nfil
    for j=1:Ncol
        mpq= mpq + i^p*j^q*o(i,j);
    end
end
m40=mpq;

%m04
p=0; q=4;
mpq=0;
for i=1:Nfil
    for j=1:Ncol
        mpq= mpq + i^p*j^q*o(i,j);
    end
end
m04=mpq;

%m41
p=4; q=1;
mpq=0;
for i=1:Nfil
    for j=1:Ncol
        mpq= mpq + i^p*j^q*o(i,j);
    end
end
m41=mpq;

%m14
p=1; q=4;
mpq=0;
for i=1:Nfil
    for j=1:Ncol
        mpq= mpq + i^p*j^q*o(i,j);
    end
end
m14=mpq;


%m42
p=4; q=2;
mpq=0;
for i=1:Nfil
    for j=1:Ncol
        mpq= mpq + i^p*j^q*o(i,j);
    end
end
m42=mpq;

%m24
p=2; q=4;
mpq=0;
for i=1:Nfil
    for j=1:Ncol
        mpq= mpq + i^p*j^q*o(i,j);
    end
end
m24=mpq;

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

%m44
p=4; q=4;
mpq=0;
for i=1:Nfil
    for j=1:Ncol
        mpq= mpq + i^p*j^q*o(i,j);
    end
end
m44=mpq;

%m54
p=5; q=4;
mpq=0;
for i=1:Nfil
    for j=1:Ncol
        mpq= mpq + i^p*j^q*o(i,j);
    end
end
m54=mpq;

%m45
p=4; q=5;
mpq=0;
for i=1:Nfil
    for j=1:Ncol
        mpq= mpq + i^p*j^q*o(i,j);
    end
end
m45=mpq;




%Momentos centrados
mu20= m20-m10^2/m00;
mu02= m02-m01^2/m00;

%Prueba:
mu43= m45  -m43^2/m33;
mu34= m54  -m34^2/m33;

%Vector de caracteristicas
x=[mu43/m33; mu34/m33];