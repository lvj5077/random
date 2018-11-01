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

