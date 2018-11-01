clear 
close all
formatSpec = '//Users/lingqiujin/clams_data/pcd/%d.pcd';
figure;
for index = 1:50:55
    path = sprintf(formatSpec,index);

    ptCloud = pcread(path);
    pcshow(ptCloud);
    hold on
end

% x = linspace(-1.5,1.5,100); 
% y = linspace(-1.5,1.5,100); 

[x, y] = meshgrid(-1.5:0.01:1.5);

[h,w]=size(x);
x = reshape(x, [1,h*w]);
y = reshape(y, [1,h*w]);
z = zeros(size(x)); % Solve for z data
pts = pointCloud([x; y; z]');  

A = eye(4);
R = [0.9980   -0.0182    0.0608;
     0.0242    0.9949   -0.0982;
    -0.0587    0.0995    0.9933];
T = [-141.532497028991,-237.712814227502,795.028169859300]/1000;
A(1:3,1:3) = R;
A(4,1:3) = T;
tform = affine3d(A);
ptCloudOut = pctransform(pts,tform);

hold on
pcshow(ptCloudOut)