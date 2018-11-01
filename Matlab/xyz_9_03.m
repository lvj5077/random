clear 
close all


IntrinsicMatrix = [602.257339558239,0,0;0,603.053042362620,0;324.529829900972,238.230986563994,1];
radialDistortion = [0.0442998494990126,0.129710595652939]; 
tangentialDistortion = [0.000275815245669840,0.00251000308882362];
cameraParams = cameraParameters('IntrinsicMatrix',IntrinsicMatrix, ...
                                'RadialDistortion',radialDistortion, ...
                                'TangentialDistortion',tangentialDistortion); 

I = imread('/Users/lingqiujin/check_xyz/color/0113.png');
J = undistortImage(I,cameraParams);

figure; imshowpair(imresize(I, 0.5),imresize(J, 0.5),'montage');
title('Original Image (left) vs. Corrected Image (right)');

imwrite(J,'/Users/lingqiujin/check_xyz/color/0113_rec.png');

I = imread('/Users/lingqiujin/check_xyz/depth_reg/0113.png');
J = undistortImage(I,cameraParams);
imwrite(J,'/Users/lingqiujin/check_xyz/depth_reg/0113_rec.png');

%%

[imagePoints,boardSize,imagesUsed] = detectCheckerboardPoints('/Users/lingqiujin/check_xyz/color/0113_rec.png');

imagePoints = round(imagePoints);
[num_p,~] = size(imagePoints);

colorPath = '/Users/lingqiujin/check_xyz/color/0113_rec.png';
depthPath = '/Users/lingqiujin/check_xyz/depth_reg/0113_rec.png';

I = imread(colorPath);
I_d = imread(depthPath);
figure()
imshow(I);
hold on;
plot(imagePoints(:,1),imagePoints(:,2),'ro');
hold on;
scatter(imagePoints(1,1),imagePoints(1,2),'r','filled');
scatter(imagePoints(num_p,1),imagePoints(num_p,2),'b','filled');


pts = zeros(3,num_p);
s=1;
for n = 1:num_p
    pts(3,n) = I_d(imagePoints(n,2),imagePoints(n,1));
    pts(1,n) = (imagePoints(n,1)-324.529829900972/s)*pts(3,n)/(602.257339558239/s);
    pts(2,n) = (imagePoints(n,2)-238.230986563994/s)*pts(3,n)/(603.053042362620/s);
end


figure()
% 
% pc = image2depth(I_d);
% scatter3(pc(1,:), pc(2,:), pc(3,:));
% hold on
% 
axis equal;
scatter3(pts(1,:), pts(2,:), pts(3,:));
hold on 
scatter3(pts(1,1), pts(2,1), pts(3,1),'r','filled');
% hold on
% scatter3(pts(1,num_p), pts(2,num_p), pts(3,num_p),'b','filled');
% 
% 


for n = 1:num_p-1

    l = norm(pts(:,n)-pts(:,n+1))
    
end