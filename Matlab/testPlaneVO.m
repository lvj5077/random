clear 
close all
formatSpec = '//Users/lingqiujin/clams_data/pcd/%d.pcd';
figure;
for index = 1:50:301
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


imageFileNames = {};
%% Define images to process
imageFileNames = {
    '/Users/lingqiujin/testPlane/051.png',...
    '/Users/lingqiujin/testPlane/0101.png',...
    '/Users/lingqiujin/testPlane/0151.png',...
    '/Users/lingqiujin/testPlane/0201.png',...
    '/Users/lingqiujin/testPlane/0251.png',...
    '/Users/lingqiujin/testPlane/0301.png',...
    };

% Detect checkerboards in images
[imagePoints, boardSize, imagesUsed] = detectCheckerboardPoints(imageFileNames);
imageFileNames = imageFileNames(imagesUsed);
numImages = size(imageFileNames, 2)

% Read the first image to obtain image size
originalImage = imread(imageFileNames{1});
[mrows, ncols, ~] = size(originalImage);

% Generate world coordinates of the corners of the squares
squareSize = 50;  % in units of 'millimeters'
worldPoints = generateCheckerboardPoints(boardSize, squareSize);

rotationVectors = zeros(3, numImages);
translationVectors = zeros(3, numImages); 

% fx = 618.469482421875;
% fy = 618.7632446289062;
% skew = 0;
% cx = 323.09356689453125;
% cy = 237.54339599609375;

fx = 662.348631509985;
fy = 673.158030712524;
skew = 0;
cx = 349.358336125349;
cy = 238.979555744906;

A = [fx, skew, cx; ...
     0, fy, cy; ...
     0, 0, 1];

Ainv = inv(A);

for i = 1:numImages
    H = fitgeotrans(worldPoints, imagePoints(:,:,i), 'projective');
    H = (H.T)';
    H = H / H(3,3);
    
    h1 = H(:, 1);
    h2 = H(:, 2);
    h3 = H(:, 3);
    lambda = 1 / norm(Ainv * h1); %#ok
    
    % 3D rotation matrix
    r1 = lambda * Ainv * h1; %#ok
    r2 = lambda * Ainv * h2; %#ok
    r3 = cross(r1, r2);
    R = [r1,r2,r3];
    
    rotationVectors(:, i) = vision.internal.calibration.rodriguesMatrixToVector(R);
    
    % translation vector
    t = lambda * Ainv * h3;  %#ok
    translationVectors(:, i) = t;
end

rotationVectors = rotationVectors';
translationVectors = translationVectors';


% close all
[x, y] = meshgrid(-1.5:0.01:1.5);

[h,w]=size(x);
x = reshape(x, [1,h*w]);
y = reshape(y, [1,h*w]);
z = zeros(size(x)); % Solve for z data
pts = pointCloud([x; y; z]');  

% figure
for i = 1:numImages
%     subplot(2,3,i)
%     index = 1+50*numImages;
%     path = sprintf(formatSpec,index);
%     ptCloud = pcread(path);
%     pcshow(ptCloud);
    
    A = eye(4);
    R = rotationVectorToMatrix(rotationVectors(i,:,:,:));
    T = translationVectors(i,:,:,:)/1000;
    
    
    A(1:3,1:3) = R;
    A(4,1:3) = T;
    tform = affine3d(A);
    ptCloudOut = pctransform(pts,tform);
    
    hold on
    pcshow(ptCloudOut)    
end


%%
close all
formatSpec = '//Users/lingqiujin/clams_data/pcd/%d.pcd';
figure;
for i = 1:numImages
    index = 1+i*50;
%     figure;
    axis equal
    path = sprintf(formatSpec,index);

    ptCloud = pcread(path);
    
    subplot(2,3,i)
    pcshow(ptCloud);
    
    A = eye(4);
    R = rotationVectorToMatrix(rotationVectors(i,:,:,:));
    T = translationVectors(i,:,:,:)/1000;
    
    
    A(1:3,1:3) = R;
    A(4,1:3) = T;
    tform = affine3d(A);
    ptCloudOut = pctransform(pts,tform);
    
    hold on
    pcshow(ptCloudOut)  
    
end
