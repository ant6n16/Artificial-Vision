function [props,id_monedas,i_otro] = indicaTipo(props)
    
    id=zeros(1,length(props));
    
    % Recorremos todos los objetos:
    for o=1:length(props)
        
        % Si la circularidad es aproximadamente 1 asignamos ese objeto como
        % moneda, si no lo asignamos como otro:
        if(round(props(o).Circularidad) == 1)
            props(o).Tipo='Moneda';
            
            % A los objetos Moneda le asignamos un identificador igual a 1:
            id(o)=1;
        else
            props(o).Tipo='Otro';
            % A los objetos Otro le asignamos un identificador igual a 0:
            id(o)=0;
        end
    end
    
    % Contamos cuantas monedas hemos detectado:
    id_monedas=find(id ~= 0);
    id_otro=find(id~=1);
end