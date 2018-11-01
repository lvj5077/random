function [rotationVectors, translationVectors] = computeT(squareSize,boardSize,imagePoints,imageFileNames,fx,fy,cx,cy,skew)



numImages = size(imageFileNames, 2);

% Generate world coordinates of the corners of the squares
% squareSize = 50;  % in units of 'millimeters'
worldPoints = generateCheckerboardPoints(boardSize, squareSize);

rotationVectors = zeros(3, numImages);
translationVectors = zeros(3, numImages); 





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
end