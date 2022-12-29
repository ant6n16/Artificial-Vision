function [props,cc]=calculaPropGeom(I,varargin)

% Obtenemos en cc los diferentes objetos que componen la imagen:
cc=bwconncomp(I);
[M,N]=size(I);

% C?lculo del per?metro con regionprops:
per=regionprops(cc, 'Perimeter');

%Recorremos todos los objetos:
for o=1:cc.NumObjects
    
    pixelList= cell2mat(cc.PixelIdxList(o));
    mask=zeros(M,N); mask(pixelList)=1; obj=mask.*I;
    
    % Definicion de Momentos que se usaran para determinadas propiedades
    m00 = sum(sum(obj));
    m10 = 0;   m01 = 0; m11= 0; 
    m20 = 0; m02 = 0;
    for x=1:N
        for y=1:M
            m10 = m10 + x * obj(y,x);
            m01 = m01 + y * obj(y,x);
            m11 = m11 + x * y * obj(y,x);
            m20 = m20 + x^2 * obj(y,x);
            m02 = m02 + y^2 * obj(y,x);
        end
    end
    
    % Bucle para calcular todas las propiedades pedidas en la llamada de la
    % funci?n:
    for k=1:length(varargin)
    
    % Asignaci?n del ?rea:
    if (strcmp(varargin{k},'Area'))
        props(o).Area = m00;
    end

    % Asignaci?n del centro:
    if (strcmp(varargin{k},'Centro'))
        xCM = m10/m00;
        yCM = m01/m00;
        props(o).Centro=[xCM,yCM];
    end
    
    % Asignaci?n del per?metro:
    if (strcmp(varargin{k},'Perimetro'))
        props(o).Perimetro=per(o).Perimeter;
    end
    
    % Asignaci?n de la circularidad:
    if (strcmp(varargin{k},'Circularidad'))
        props(o).Circularidad=1/(4*pi)*(per(o).Perimeter^2)/props(o).Area;
            
    end

    % Asignaci?n de la orientaci?n:
    if(strcmp(varargin{k},'Orientacion'))
        u11= m11 - (m10*m01/m00);
        u20= m20 - (m10^2/m00);
        u02= m02 - (m01^2/m00);
        
        %C?lculo del ?ngulo:
        props(o).Orientacion =(1/2)*atan(2*u11/(u20-u02))*180/pi;
    end
    
    % Asignaci?n del BoundingBox llamando a una funci?n externa:
    if(strcmp(varargin{k},'BoundingBox'))
        rect=BoundingBox(cc.ImageSize);
        props(o).BoundingBox=rect;
    end
    
    end
end


end