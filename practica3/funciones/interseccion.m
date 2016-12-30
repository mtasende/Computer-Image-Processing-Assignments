function X=interseccion(r1,th1,r2,th2,centro)

N = length(r1);
X = zeros(N,2);
th1R = pi*th1/180;
th2R = pi*th2/180;

for i=1:N
    X(i,:) = ([cos(th1R(i)) sin(th1R(i));cos(th2R(i)) sin(th2R(i))]\[r1(i);r2(i)]) + centro';
end
