clc
clear all
close all

%I = imread('lena.bmp');
I = rgb2gray(imread('miCI1chica.jpg'));


%rotI = imrotate(I,33,'crop');
rotI = I;
BW = edge(rotI,'canny'); % Implementar esto
imshow(BW)
figure
%[H,T,R] = hough(BW,'RhoResolution',4,'Theta',[-90:-85 -5:5 85:89]); %Implementar esto
[H,T,R] = hough(BW,'RhoResolution',4); %Implementar esto
imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
%P  = houghpeaks(H,15,'threshold',ceil(0.3*max(H(:)))); %Implementar esto
P  = houghpeaks(H,25,'threshold',ceil(0.3*max(H(:)))); %Implementar esto
x = T(P(:,2)); 
y = R(P(:,1));
plot(x,y,'s','color','white');

%Lo de abajo puede ir en una funcion aparte-------
% Find lines and plot them
lines = houghlines(BW,T,R,P,'FillGap',5,'MinLength',90);
figure, imshow(rotI), hold on
max_len = 0;
for k = 1:length(lines)
 xy = [lines(k).point1; lines(k).point2];
 plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

 % plot beginnings and ends of lines
 plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
 plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

 % determine the endpoints of the longest line segment 
 len = norm(lines(k).point1 - lines(k).point2);
 if ( len > max_len)
   max_len = len;
   xy_long = xy;
 end
end
