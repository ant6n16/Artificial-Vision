function props = indicaTamanio(props,ids)
    
    % Obtenemos las areas de todos los objetos que estan en el struc:
    area=struc(props(ids).Area);
    
    % Obtenemos el area maxima y minima:
    amax = max(area);
    amin = min(area);
    
    % Obtenemos el intervalo pedido, dividido en tres partes:
    intervalo=(amax-amin)/3;
    
    % Determinamos los valores limites que tendran las areas para ser
    % consideradas grandes o pequenas:
    a_gran = amax-intervalo;
    a_peq = amin + intervalo;
    
    % Bucle para recorrer todos los objetos:
    for o=1:length(props)
        
        % Solo nos interesan las monedas:
        if(strcmp(props(o).Tipo,'Moneda'))
            
            % Si el area es menor que a_peq le asignamos tamano 1 (moneda
            % pequena):
            if(props(o).Area < a_peq)
                props(o).Tamanio=1;
                
            % Si el area es mayor que a_gran le asignamos tamano 3 (moneda
            % grande):
            elseif(props(o).Area > a_gran)
                props(o).Tamanio=3;
                
            % Si no es ni uno ni otro tenemos una moneda mediana:    
            else
                props(o).Tamanio=2;
            end
        else
            props(o).Tamanio=0;
        end
    end
end
