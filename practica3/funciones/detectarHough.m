function imaRes = detectarHough(imagen) %umbral, dtheta, dr

N = 50;

%implementar esto
[h,theta,r] = hough(imagen); %Acá se agregan dtheta dr
picos = houghpeaks(h,N,'Threshold',0.001); %Acá juega umbral
imaRes = houghlines(h,theta,r,picos,'FillGap',5,'MinLength',7);


