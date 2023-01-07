close all
clear

f=imread('CEt401.png');
imshow(f)
imshow(f,'InitialMagnification',400) %Para ver la imagen mas grande
figure, imhist(f);
axis([-10 256 0 10600])

umbral = 20;
plant = f > umbral;
figure; imshow(uint8(255*plant));

%pru_momentos.m
%m_vectorx.m

m_vectorx;
x