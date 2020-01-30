function [gama] = VarianceFunction(t,array)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

i_of_t0 = movmean(array,1);
i_of_t = movmean(array,t+1);

gama = var(i_of_t)/var(i_of_t0);

end

