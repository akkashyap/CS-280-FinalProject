function [ T ] = Torque( beam_length )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
L1 = beam_length;
k= (2*5.77*10^(-14))/L1;


angles = zeros(1000,1);
angles_plot = zeros(1000,1);
%%ok angles really goes from 0 to 90 but divided by 1000
%% pi/2 

for x = 1:1000
   angles(x) = (x-1)*(pi/2000); 
   angles_plot(x) = (x-1)*(90/1000);
end

T = (angles.*k);

%figure(1);
%hold;
%colors= {'red'; 'blue'; 'green'; 'magenta';'cyan'};

%for x =1:1
%    plot(angles_plot, F./x, colors{x});
%end


end

