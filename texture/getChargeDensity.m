function [ rho, C ] = getChargeDensity(length, delta, V)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

%length = 40*10^(-6);
%delta = 2*10^(-6);
%V= 10;
a = 1*10^(-6);
epsilon = 8.85*10^(-12);
er = 3.9;


sizeOfA = length/delta;

A = zeros(sizeOfA, sizeOfA);

for i = 1: sizeOfA
    for j = 1:sizeOfA
        temp = 0;
        if(i == j)
            numerator = delta/2 + ((delta/2)^2 + a^2)^(1/2);
            denominator = ((delta/2)^2 + a^2)^(1/2) - delta/2;
            temp = 2 *log(numerator/denominator);
            %temp = 2*log(delta/a);
        else
            temp = 1/(abs(i-j));
            
        end
        A(i, j) = temp;
    end
end

%keyboard;
B = V*4*pi*epsilon*er*ones(sizeOfA, 1);
rho = (A^-1)*B;
Q = delta*sum(rho);
C = 2*Q/V;

end

