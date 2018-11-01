close all

depth =imread('/Users/lingqiujin/28_08_2018_13_39_02/depth_reg/1535477942.992275854.png');
depthP = depth(1:300,1:300);
dd = imresize(depthP,1/2);

ddm = medfilt2(dd,[15 15]);
ddg = imgaussfilt(dd, 10);

ddb = imbilatfilt(dd,5,5);

figure();surf(dd);hold on;surf(ddm-200);hold on;surf(ddg-400);hold on;surf(ddb-600)

ddsm = dd-ddm;
ddsm(ddsm> 200) = 0;
figure();
surf(ddsm)
title("ddsm")

ddsg = dd-ddm;
ddsg(ddsg> 200) = 0;
figure();
surf(ddsg)
title("ddsg")
%% main
close all
clear all
% 
% formatSpec = '/Users/lingqiujin/clams_data/lab_8_30/acc_move/depth_reg/0%d.png';
% minF = 350;
% maxF = 850;
% step = 1;

formatSpec = '/Users/lingqiujin/clams_data/index/depth_reg/0%d.png';
minF = 1;
maxF = 350;
step = 1;

d = minF:step:maxF;
error = zeros();
count = 0;
ddsmM = zeros();
for index = minF:step:maxF
    count = count+1
    path = sprintf(formatSpec,index);
    depth =imread(path);
    dd = imresize(depth,1/2);
    ddm = medfilt2(dd,[15 15]);
%     ddg = imgaussfilt(dd, 5);
%     ddb = imbilatfilt(dd,5,5);



    dd  = dd (20:220,20:300);
    ddm = ddm(20:220,20:300);
%     ddg = ddg(10:200,10:300);
%     ddb = ddb(10:200,10:300);

    
%     subplot(2,2,1);
%     surf(dd)
%     axis([0 200 0 300 500 2000])
%     title('Origion')
%     subplot(2,2,2);
%     surf(ddm)
%     axis([0 200 0 300 500 2000])
%     title('median')
%     subplot(2,2,3);
%     surf(ddg)
%     axis([0 200 0 300 500 2000])
%     title('Gaussian')
%     subplot(2,2,4);
%     surf(ddb)
%     axis([0 200 0 300 500 2000])
%     title('Bilateral')

    ddsm = abs(dd-ddm);
    

    ddsm(ddsm> 500) = 0;
    errorMax(count) = max(max(ddsm));
    errorMean(count) = mean(mean(ddsm));
    dm(count) = mean(mean(ddm));
    dr(count) = mean(mean(dd));
    
%     subplot(3,3,count);
%     surf(ddsm)
%     title(int2str(index))
        
    ddsmM = ddsmM+ddsm;

end

% subplot(3,3,9);
% surf(ddsmM/7)
% title("ddsmM")

% figure();
% surf(ddsmM/count)
% title("ddsmM")

figure();
subplot(2,1,1)
plot(dm,errorMax)
title("max")
subplot(2,1,2)
plot(dm,errorMean)
title("mean")

% figure();
% plot(d,dm, d,dr)
% ddsg = dd-ddm;
% ddsg(ddsg> 200) = 0;
% figure();
% surf(ddsg)
% title("ddsg")

%%
close all

formatSpec = '/Users/lingqiujin/clams_data/middle/depth_reg/0%d.png';
% index = 2;
ddsmM = zeros();
count = 0;
figure();
for index = 300:1:306
    count = count+1;
    path = sprintf(formatSpec,index);
    depth =imread(path);
    dd = imresize(depth,1/2);
    ddm = medfilt2(dd,[15 15]);
    ddg = imgaussfilt(dd, 5);
    ddb = imbilatfilt(dd,5,5);



    dd  = dd (10:200,10:300);
    ddm = ddm(10:200,10:300);
    ddg = ddg(10:200,10:300);
    ddb = ddb(10:200,10:300);

    
%     subplot(2,2,1);
%     surf(dd)
%     axis([0 200 0 300 500 2000])
%     title('Origion')
%     subplot(2,2,2);
%     surf(ddm)
%     axis([0 200 0 300 500 2000])
%     title('median')
%     subplot(2,2,3);
%     surf(ddg)
%     axis([0 200 0 300 500 2000])
%     title('Gaussian')
%     subplot(2,2,4);
%     surf(ddb)
%     axis([0 200 0 300 500 2000])
%     title('Bilateral')

    ddsm = abs(dd-ddm);
    
    ddsm(ddsm> 200) = 0;
    ddsm = imadjust(ddsm);
    
    subplot(3,3,count);
    surf(ddsm)
    title(int2str(index))
        
    ddsmM = ddsmM+ddsm;

end

subplot(3,3,9);
surf(ddsmM/7)
title("ddsmM")

figure();
surf(ddsmM)
title("ddsmM")
% ddsg = dd-ddm;
% ddsg(ddsg> 200) = 0;
% figure();
% surf(ddsg)
% title("ddsg")
%%
clear 
close all
[x,y,z,V] = flow(50);
% % x = 1:240;
% % y = 1:360;
% z = 
noisyV = V + 0.1*double(rand(size(V))>0.95) - 0.1*double(rand(size(V))<0.05);


filteredV = medfilt3(noisyV);


subplot(1,2,1)
hpatch1 = patch(isosurface(x,y,z,noisyV,0));
isonormals(x,y,z,noisyV,hpatch1)
set(hpatch1,'FaceColor','red','EdgeColor','none')
daspect([1,4,4])
view([-65,20]) 
axis tight off
camlight left
lighting phong

subplot(1,2,2)
hpatch2 = patch(isosurface(x,y,z,filteredV,0));
isonormals(x,y,z,filteredV,hpatch2)
set(hpatch2,'FaceColor','red','EdgeColor','none')
daspect([1,4,4])
view([-65,20])
axis tight off
camlight left 
lighting phong

%%
% the data that you want to plot as a 3D surface.
[x,y,z] = peaks;
% [x,y] = meshgrid(1:0.5:10,1:20);
% z = sin(x) + cos(y);

% x = pts(1,:);
% y = pts(2,:);
% z = pts(3,:);

% clear 
% xx = 1:200;
% 
% for i =1:200
%     x(i,:) = xx;
% end
% 
% 
% y = x';
% formatSpec = '/Users/lingqiujin/clams_data/index/depth_reg/0%d.png';
% index = 50;
% path = sprintf(formatSpec,index);
% depth =imread(path);
% pc = image2depth(depth);
% dd = imresize(depth,1/2);
% dd  = dd (xx+10,xx+80);
% 
% ddb = imbilatfilt(dd);
% ddm = medfilt2(dd,[15 15]);
% 
% ddsm = ddm - ddb;
% ddsm(abs(ddsm)> 20) = 0;
% 
% z = ddsm;
%  
% get the corners of the domain in which the data occurs.
min_x = min(min(x));
min_y = min(min(y));
max_x = max(max(x));
max_y = max(max(y));
 
% the image data you want to show as a plane.
planeimg = abs(z);
 
% scale image between [0, 255] in order to use a custom color map for it.
minplaneimg = min(min(planeimg)); % find the minimum
scaledimg = (floor(((planeimg - minplaneimg) ./ ...
    (max(max(planeimg)) - minplaneimg)) * 255)); % perform scaling
 
% convert the image to a true color image with the jet colormap.
colorimg = ind2rgb(scaledimg,jet(256));
 
% set hold on so we can show multiple plots / surfs in the figure.
figure; hold on;
 
% do a normal surface plot.
surf(x,y,z,'edgecolor','none');
 
% set a colormap for the surface
colormap(gray);
 
% desired z position of the image plane.
imgzposition = -10;
 
% plot the image plane using surf.
surf([min_x max_x],[min_y max_y],repmat(imgzposition, [2 2]),...
    colorimg,'facecolor','texture')
 
% set the view.
view(45,30);
 
% label the axes
xlabel('x');
ylabel('y');
zlabel('z');

%%
close all
clear all

formatSpec = '/Users/lingqiujin/clams_data/index/depth_reg/0%d.png';

index = 50;
path = sprintf(formatSpec,index);

path = '/Users/lingqiujin/test.png';
depth =imread(path);
dd = imresize(depth,1/2);

% ddm = medfilt2(dd,[15 15]);
% ddg = imgaussfilt(dd, 5);
% ddb = imbilatfilt(dd,5,5);

pts = image2depth(dd);

axis equal;
scatter3(pts(1,:), pts(2,:), pts(3,:));
hold on 
pts_m = image2depth(ddm);
scatter3(pts_m(1,:), pts_m(2,:), pts_m(3,:)+400,'r');

xlabel('X axis'); 
ylabel('Y axis');
zlabel('Z axis');
   

% figure();
% scatter3(pts(1,:), pts(2,:), ( pts_m(3,:)-pts(3,:)) ,'b');
% 
% xlabel('X axis'); 
% ylabel('Y axis');
% zlabel('Z axis');
% 

    