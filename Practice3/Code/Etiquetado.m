function [fEtiq,nEtiqs] = Etiquetado(f,nMaxEtiqs)

% Almacenamos en fEtiq la imagen original:
fEtiq = f;

% Variable para ir contando el numero de etiquetas:
nEtiqs = 0;

% Bucle para recorrer todos los objetos:
for i=1:length(nMaxEtiqs)
    
    % Segun el tamano representa el texto necesario con el color
    % correspondiente al tamano de cada moneda:
if (nMaxEtiqs(i).Tamanio == 1) 
   fEtiq = insertText(fEtiq,nMaxEtiqs(i).Centro,'Moneda Pequena','FontSize',50, ...
    'BoxOpacity',0,'TextColor','y');

    % Cada vez que inserta una etiqueta incrementa el valor de la variable:
   nEtiqs = nEtiqs + 1; 
   
elseif (nMaxEtiqs(i).Tamanio == 2)
   fEtiq = insertText(fEtiq,nMaxEtiqs(i).Centro,'Moneda Mediana','FontSize',50, ...
    'BoxOpacity',0,'TextColor','m');
   nEtiqs = nEtiqs + 1;  
    
elseif (nMaxEtiqs(i).Tamanio == 3)
   fEtiq = insertText(fEtiq,nMaxEtiqs(i).Centro,'Moneda Grande','FontSize',50, ...
    'BoxOpacity',0,'TextColor','r');
   nEtiqs = nEtiqs + 1; 
   
else
   fEtiq = insertText(fEtiq,nMaxEtiqs(i).Centro,'Otro','FontSize',50, ...
    'BoxOpacity',0,'TextColor','g');
   nEtiqs = nEtiqs + 1; 
    
end 
end

end


