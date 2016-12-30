clc
clear all
close all

A = zeros(5,5);
A(2:4,2:4)=1;

umbral = 0.5;

%imagesc(A)
v = [1 0 1 0]; %variar v para probar casos particulares
[p1 p2 n] = lut(v);
plot([p1(1,2) p1(1,4)],[-p1(1,1) -p1(1,3)],'*r') %El signo negativo es porque las "y" crecen hacia abajo.
hold on
plot([p2(1,2) p2(1,4)],[-p2(1,1) -p2(1,3)],'og') %El signo negativo es porque las "y" crecen hacia abajo.
axis([-0.5 1.5 -1.5 0.5])
legend('p1','p2');
if(n==2)
    figure
    plot([p1(2,2) p1(2,4)],[-p1(2,1) -p1(2,3)],'*r') %El signo negativo es porque las "y" crecen hacia abajo.
    hold on
    plot([p2(2,2) p2(2,4)],[-p2(2,1) -p2(2,3)],'og') %El signo negativo es porque las "y" crecen hacia abajo.
    axis([-0.5 1.5 -1.5 0.5])
    legend('p1','p2');
end

M = length(A(:,1));
N = length(A(1,:));
for i = 1:M-1
    for j = 1:N-1
        v = [A(i,j) A(i+1,j) A(i+1,j+1) A(i,j+1)];
        [p1,p2,n]=lut(v);
        %Ahora interpolo para hallar los vertices del(de los) borde(s)
        %Con el umbral en 0.5 deberian quedar en el medio
    end
end

        
        
