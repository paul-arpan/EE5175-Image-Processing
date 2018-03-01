function [ mean ] = GaussianFit( y,x,delta_d )

lny=log(y);
mean_num = ( x(3)^2.0 -x(2)^2.0 )* (lny(2) - lny(1)) - (x(1)^2.0 - x(2)^2.0)* (lny(2) - lny(3));
mean_den = 2.0 * delta_d*(2.0*lny(2) - lny(1) - lny(3));
mean = mean_num/mean_den;
end

