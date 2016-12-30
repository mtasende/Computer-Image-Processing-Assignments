function dibujarLineas(rho,theta,x,centro)
%rho y theta pueden ser escalares o vectores del mismo tamanio

N = length(rho);
thetaR = pi*theta/180;

for i=1:N
    y = ( -tan(thetaR(i))*(x-centro(2))+(rho(i)/cos(thetaR(i))) ) +centro(1);
    plot(x,y,'g','LineWidth',2);
    hold on
end
hold off

