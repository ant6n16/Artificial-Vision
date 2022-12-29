function T = creaTronoVirtual(x, y, a, b)
%El objeto elegido es un trono y para ello se van a definir los puntos
%diviendiendo el trono en varias partes:
% 1.Base inferior
% 2.Base superior
% 3.Respaldo
% Para definirlos se usar?n los par?metros de entrada para
% la base inferior y el resto en funci?n de ella.
% . x: desplazamiento respecto al eje x del objeto referencia
% . y: desplazamiento respecto al eje y del objeto referencia
% . a: lado menor del rect?ngulo
% . b: lado mayor del rect?ngulo
% Los par?metros de salida son:
% . T: matriz de puntos a transformar
% El objeto virtual no estar? desplazado en altura (eje z) respecto a
% la referencia.
%
% La nomenclatura de las variables sigue el patr?n:
% . _i : base inferior
% . _s : base superior
% . _r : respaldo
% . _rb: reposabrazos
%
% Finalmente se concatenar?n para crear la matriz de puntos del objeto.

if nargin==4
    %1. Base inferior: rect?ngulo de lados a y b.
    
    %Coordenadas de la base, en funcion al desplazamiento y los lados
    P1=[x y]';
    P2=[x+a y]';
    P3=[x+a y+b]';
    P4=[x y+b]';
    %Concatenamos a?adiendo la fila de z= 0
    B_i=[P1 P2 P3 P4; zeros(1,4)];
    
    %2. Base superior: rect?ngulo de lados 1/2 de a y b
    % Se centra el segundo rect?ngulo en referencia al otro desplazando las
    % coordenadas x e y 0.5/2= 1/4, correspondientemente para que quede
    % centrado y la altura se define como el doble del lado m?s largo
    
    %Coordenadas nuevas
    z_s=2*b; x_s=x+1/4*a; y_s=y+1/4*b;
    %Lados nuevos
    a_s=0.5*a; b_s=0.5*b;
    
    P1=[x_s y_s]';
    P2=[x_s+a_s y_s]';
    P3=[x_s+a_s y_s+b_s]';
    P4=[x_s y_s+b_s]';
    %Concatenamos a?adiendo la altura
    B_s=[P1 P2 P3 P4; z_s*ones(1,4)];    
     
    %3. Respaldo: se definir?n 2 puntos que marcar?n las esquinas de un
    %trapecio cuyo lado menor coincide con un lado de la base superior.
    %Las coordenadas y se define para mayor atractivo del objeto, la x se
    %mantiene igual a las de la base mayor.
    
    %Coordenadas nuevas
    
    P1=[x y+1/8*b]';
    P2=[x y+b-1/8*b]';
    %Concatenamos a?adiendo la altura
    R=[P1 P2; 2*z_s*ones(1,2)];
    
    
    %Finalmente se concatena la matriz objeto
    T=[B_i B_s R];
    
else
    disp('ERROR:Numero de argumentos incorrecto');
    disp('Incluya coordenadas x e y del objeto virtual y lados de la base a y b');

end