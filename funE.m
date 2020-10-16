function [y] = funE(x)   
global inp;
a = inp(1);
mass = inp(2);
V = inp(3);
hmod = 0.07619972979; 

alpha = sqrt(2*mass*x/hmod);
beta = sqrt((2*mass*(V-x))/hmod);
y = alpha*tan(alpha*a) - beta;
end

