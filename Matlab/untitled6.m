I = imread('/Users/lingqiujin/1537369968.430872629.png');
I = rgb2gray( I );
C = corner(I);
imshow(I)
hold on
plot(C(:,1),C(:,2),'r*');

figure,plot(C(:,1),C(:,2),'r*');

% wp = [0 0; 70 0 ; 140 0; ]
%%
imagePoints = [306 158;340 162;379 167;413 172;301 191;337 196;374 201;409 205;334 232;368 236];
worldPoints = [0 0; 70 0;   140 0;  210 0;70 0;70 70; 140 70;210 70;70 140;140 140];


fx = 618.469482421875;
fy = 618.7632446289062;
skew = 0;
cx = 323.09356689453125;
cy = 237.54339599609375;

% fx = 662.348631509985;
% fy = 673.158030712524;
% skew = 0;
% cx = 349.358336125349;
% cy = 238.979555744906;

A = [fx, skew, cx; ...
     0, fy, cy; ...
     0, 0, 1];

Ainv = inv(A);

H = fitgeotrans(worldPoints, imagePoints, 'projective');
H = (H.T)';
H = H / H(3,3);

h1 = H(:, 1);
h2 = H(:, 2);
h3 = H(:, 3);
lambda = 1 / norm(Ainv * h1); 

% 3D rotation matrix
r1 = lambda * Ainv * h1; 
r2 = lambda * Ainv * h2; 
r3 = cross(r1, r2);
R = [r1,r2,r3];

rotationVectors = vision.internal.calibration.rodriguesMatrixToVector(R)

t = lambda * Ainv * h3