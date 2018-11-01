function [pc] = image2depth(I_d)
[h,w]= size(I_d);
s = 640/w;
pc = zeros(3,480*640);
count = 0;
for i=1:h
    for j = 1:w
        count = count+1;
        if (I_d(i,j)>200 && I_d(i,j)<800)
            pc(3,count) = I_d(i,j);
            pc(1,count) = (j-323.09356689453125/s)*I_d(i,j)/(618.469482421875/s);
            pc(2,count) = (i-237.54339599609375/s)*I_d(i,j)/(618.7632446289062/s);
%             pc(1,count) = (j-322.1780700683594/s)*I_d(i,j)/(385.3685607910156/s);
%             pc(2,count) = (i-236.56320190429688/s)*I_d(i,j)/(385.3685607910156/s);
        end
    end
end
end



%   frame_id: "camera_depth_optical_frame"
% height: 480
% width: 640
% distortion_model: "plumb_bob"
% D: [0.0, 0.0, 0.0, 0.0, 0.0]
% K: [385.3685607910156, 0.0, 322.1780700683594, 0.0, 385.3685607910156, 236.56320190429688, 0.0, 0.0, 1.0]
% R: [1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0]
% P: [385.3685607910156, 0.0, 322.1780700683594, 0.0, 0.0, 385.3685607910156, 236.56320190429688, 0.0, 0.0, 0.0, 1.0, 0.0]


% for (int m = 0; m < depth.rows; m++)
%     for (int n=0; n < depth.cols; n++)
%     {
%         ushort d = depth.ptr<ushort>(m)[n];
% 
% 
%         // if (d > 600 || d < 200 )
%         //     continue;
%         if (d == 0)
%             continue;
%         PointT p;
% 
%         p.z = double(d) / camera_factor;
%         p.x = (n - camera_cx) * p.z / camera_fx;
%         p.y = (m - camera_cy) * p.z / camera_fy;
% 
%         p.b = rgb.ptr<uchar>(m)[n*3];
%         p.g = rgb.ptr<uchar>(m)[n*3+1];
%         p.r = rgb.ptr<uchar>(m)[n*3+2];
% 
%         // if (d > 600 || d < 200 )
%         //     p.x = p.y = p.z = bad_point;
%         cloud->points.push_back( p );
%     }

% double camera_cx = 323.09356689453125;
% double camera_cy = 237.54339599609375;
% double camera_fx = 618.469482421875;
% double camera_fy = 618.7632446289062; 