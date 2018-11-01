close all; clear;
d = 3;
k = 5;
n = 500;

X = randn(d,n);
scatter3(X(1,:),X(2,:),X(3,:));
%% kmeans init with kmeans++ seeding (recomended)
% y = kmeans(X,kseeds(X,k));
% figure;
% plotClass(X,y);
% %% kmeans with random initialization 
y = kmeans(X,k);
figure;
plotClass(X,y);


%%
close all; clear;
d = 3;
k = 5;
n = 100;

X = randn(d,n);
X = X';
figure;
scatter3(X(:,1),X(:,2),X(:,3));

rng('default'); % For reproducibility
[idx,C] = kmeans(X,3);
fusedata = [X idx];

figure;
colors = 'rgb';
markers = 'osd';

for c = 1 : 3
    data = fusedata(fusedata(:,4) == c,:);
    plot3(data(:,1), data(:,2), data(:,3), [colors(c) markers(c)]);
    hold on;
end

hold on 
scatter3(C(:,1),C(:,2),C(:,3),'filled','LineWidth',50)