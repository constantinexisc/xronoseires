clear all;
close all;

t = 10000; %steps
gama = t;
%array initializetion
position_array = zeros(1,t);
    
difrence_of_time_series = zeros(1,t-1);

%initialize varianbles
curent_position = 0; %position of random walker
count_positive = 0;
count_negative = 0;

%variables for the normal distibrution
mu = 0; %mean
sigma = 1; %standar diviation
r =0;
const = 1; % step

gama_array = zeros(1,1000);

for i = 1 : t
    r = normrnd(mu,sigma);
    if(r>0)
        teliki_timi = 1;
        count_positive = count_positive + teliki_timi;
        curent_position = curent_position + 1*const;
    else
        teliki_timi = -1;
        count_negative = count_negative + teliki_timi;
        curent_position = curent_position - 1*const;
    end
    position_array(i) = curent_position;

end

figure('Name','Random_Walk');
plot((1:t),position_array)
xlabel('Time','FontSize',16) 
ylabel('Position','FontSize',16) 

saveas(gcf,'Random_walkeps.eps')
variance_of_random_walk = var(position_array)

%Derivative of time series
for i = 1 : t-1
   difrence_of_time_series(i) = position_array(i+1) - position_array(i); 
end

unknown_sigma = var(difrence_of_time_series)
unknown_sigma = sqrt(unknown_sigma)
mean_of_derivative = mean(difrence_of_time_series)
mean_value_random_wac = mean(position_array);
variance_of_time_seres_winer = var(position_array);

for i = 1:t
    gama_array(i) = VarianceFunction(i,position_array);
end

figure('Name','Variance Function');
plot((1:length(gama_array)),gama_array)
xlabel('Time','FontSize',16) 
ylabel('Gama t','FontSize',16)

figure('Name','Auto Corelesion');
autocorr(position_array)
