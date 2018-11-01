close all
clear all

clc

I = imread('/Users/lingqiujin/Desktop/map.png');
figure(1)
imshow(I)
title('Original')

I=rgb2gray(I);

figure(2)
imshow(I)
title('gray')

I(I<150) = 0;
I(I>=150) = 255;

%%
figure(3)
imshow(I)
title('black and white')

