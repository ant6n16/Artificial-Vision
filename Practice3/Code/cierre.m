function fClose = cierre(f,mask)

    % Numero de filas de la imagen
    M = size(f,1);
    
    % Aplicamos un dilatado y al resultado aplicamos un erosionado:
    fClose = images.internal.morphop(f,mask,'dilate','notpacked',M);
    fClose = images.internal.morphop(fClose,mask,'erode','notpacked',M);

end