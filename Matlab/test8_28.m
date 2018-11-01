figure()
x= 1:640;
for i = 1:50:480
    plot (x,depth(i,:))
    hold on 
end
grid on

%%

t = 10:350;                     
x = depth(20,t);
figure()
plot(t,x)

xp = 1433+200/340*(t-10);
hold on 
plot(t,xp)


y = fft(x);
yp = fft(xp);
f = (0:length(y)-1)*50/length(y);

figure()
plot(f,y,f,yp)

%%
% make our noisy function
close all
figure()
% make our noisy function
% t = linspace(1,10,1024);
% x = -(t-5).^2  + 2;
% y = awgn(x,0.5); 
% Y = fft(y,1024);
% r = 20; % range of frequencies we want to preserve

t = 10:350;
x = 1433+200/340*(t-10);
y = depth(20,t);
Y = fft(y);

r = 200000; % range of frequencies we want to preserve

rectangle = zeros(size(Y));
% rectangle(1:r+1) = 1;               % preserve low +ve frequencies
rectangle(1:r+1) = 1;  
y_half = ifft(Y.*rectangle);   % +ve low-pass filtered signal
rectangle(end-r+1:end) = 1;         % preserve low -ve frequencies
y_rect = ifft(Y.*rectangle);   % full low-pass filtered signal

hold on;
plot(t,y,'g--'); plot(t,x,'k','LineWidth',2);plot(t,y_rect,'r','LineWidth',2);
legend('noisy signal','true signal','full low-pass','Location','southwest')

figure()
gauss = zeros(size(Y));
sigma = 3;                           % just a guess for a range of ~20
gauss(1:r+1) = exp(-(1:r+1).^ 2 / (2 * sigma ^ 2));  % +ve frequencies
gauss(end-r+1:end) = fliplr(gauss(2:r+1));           % -ve frequencies
y_gauss = ifft(Y.*gauss);

hold on;
plot(t,y,'g--');plot(t,x,'k','LineWidth',2); plot(t,y_rect,'r','LineWidth',2); plot(t,y_gauss,'c','LineWidth',2);
legend('noisy signal','true signal','full low-pass','gaussian','Location','southwest')