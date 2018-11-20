function [I_out,g] = addGNoise(I_in, sigma, center, Filter_size,peak)
I_out = I_in;


%size=5; %filter size, odd number
size=Filter_size;
g=zeros(size,size); %2D filter matrix
%sigma=2; %standard deviation
%gaussian filter
for i=-(size-1)/2:(size-1)/2
    for j=-(size-1)/2:(size-1)/2
        x0=(size+1)/2; %center
        y0=(size+1)/2; %center
        x=i+x0; %row
        y=j+y0; %col
        g(y,x)=exp(-((x-x0)^2+(y-y0)^2)/2/sigma/sigma);
    end
end
%normalize gaussian filter

g=g*peak;


I_out(center(1)-Filter_size/2 : center(1)+Filter_size/2-1,center(2)-Filter_size/2 : center(2)+Filter_size/2-1) = I_out(center(1)-Filter_size/2 : center(1)+Filter_size/2-1,center(2)-Filter_size/2 : center(2)+Filter_size/2-1) + g;

end

