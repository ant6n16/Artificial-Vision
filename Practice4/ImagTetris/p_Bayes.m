%Disenio del clasificador Bayes
mi_clasificador = NaiveBayes.fit(Mx,Mc);

%Prueba del clasificador
[ncasos, nx]=size(Mx);
CI=0;
for i=1:ncasos
    k=mi_clasificador.predict(Mx(i,:));
    fprintf('\n Clase elegida: %d')
    %Contador de incorrectas
    if k~=Mc(i)
        CI=CI+1;
    end
end
fprintf('\n Para el conjunto de imagenes CE_')