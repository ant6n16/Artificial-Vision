function fOpen=apertura(f,mask)

    % Numero de filas de la imagen:
    M = size(f,1);
    
    % Aplicamos un erosionado y al resultado un dilatado:
    fOpen = images.internal.morphop(f,mask,'erode','notpacked',M);
    fOpen = images.internal.morphop(fOpen,mask,'dilate','notpacked',M);

end
