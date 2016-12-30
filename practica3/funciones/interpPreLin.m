function p=interpPreLin(v,p1,p2,v1,v2)

% vd = im2double(v);
% v1d = im2double(v1);
% v2d = im2double(v2);

if(v1==v2)
    p = (p1 + p2)/2;
else
    p = ((p2-p1)*(double(v)-double(v1))/(double(v2)-double(v1))) + p1;
end
    