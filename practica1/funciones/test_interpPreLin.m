clc
clear all
close all

A = zeros(10,10);
A(2,2) = 1;
A(3,5) = 3;

u=interpPreLin(2,[2 2],[3 5],1,3)
u=interpPreLin(3,[2 2],[3 5],1,3)
u=interpPreLin(1.5,[2 2],[3 5],1,3)


