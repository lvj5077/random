close all
clear
clc

I_org =zeros(320,240);
I =zeros(320,240);

figure()
subplot(3,1,1)
surf(I);
ctL = [];
for i=1:10
    ctP = [randi([50 270],1),randi([50 190],1)];
    pk = 5;
    if (rand()>0.5)
        pk = -5;
    end
    [I,g] = addGNoise(I, 6, ctP, 50,pk);
    ctL = [ctL;ctP];
end
I_n = I;
subplot(3,1,2)
surf(I_n);

%% ????????
dist = abs(I_n - I_org);
maxM = max(max(dist));
while maxM > 2
    [x,y]=find(dist==maxM);
    ctLf = [[x(1),y(1)]];
    [I_n,g] = deGNoise(I_n, 6, ctLf, 50,5);
    dist = abs(I_n - I_org);
    maxM = max(max(dist));
end


subplot(3,1,3),surf(I_n);