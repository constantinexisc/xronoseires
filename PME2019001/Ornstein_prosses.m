clear all;
close all;


t = 10000; %steps

%array initializetion
position_array = zeros(1,t);
ornstein_array = zeros(1,t);
first_deriveative = zeros(1,t-1);
gama_array = zeros(1,t);
%initialize varianbles
curent_position = -100; %position of random walker
count_positive = 0;
count_negative = 0;


%variables the normal distibrution
mu = 0; %mean
sigma = 1; %standar diviation
s = 2 ; %instantaneous volatility
long_term_mean = 50;% long term mean leve
speed_of_reversion = 0.01;% speed of reversion (gama)

position_array(1) = curent_position;


for i = 2 : t
    r = normrnd(mu,sigma);
    if(r>0)
        teliki_timi = 1;
        count_positive = count_positive + teliki_timi;
        curent_position = curent_position + 1;
    else
        teliki_timi = -1;
        count_negative = count_negative + teliki_timi;
        curent_position = curent_position - 1;
    end
    
    position_array(i) = position_array(i-1) + speed_of_reversion*(long_term_mean - position_array(i-1)) + s*teliki_timi;
end

figure('Name','Time Sireres Qrnsterin ');
plot((1:t),position_array)
xlabel('Time','FontSize',16) 
ylabel('Position','FontSize',16) 

saveas(gcf,'Ornstein_prosess_3.eps')

for i = 1 : t-1
   first_deriveative(i) = position_array(i+1) - position_array(i); 
end

unknown_sigma = var(first_deriveative);
unknown_sigma = sqrt(unknown_sigma);
fprintf('Sisgma of time series is %f\n',unknown_sigma);

average_value_of_time_sires = mean(position_array);
fprintf('Mean of time series is %f\n',average_value_of_time_sires);

mean_of_derivative = mean(first_deriveative);
fprintf('Mean of first derivetive of time series is %f\n',mean_of_derivative);

figure('Name','First Derivetive of Time Sires ');
plot((1:t-1),first_deriveative)
xlabel('Time','FontSize',16) 
ylabel('Position','FontSize',16) 

for i = 1:t
    gama_array(i) = VarianceFunction(i,position_array);
end
figure('Name','Variance Function');
plot((1:t),gama_array)
xlabel('Time','FontSize',16) 
ylabel('window','FontSize',16) 

denoize_array = movmean(position_array,20);

figure('Name','Denoise');
plot((1:t),denoize_array)
xlabel('Time','FontSize',16) 
ylabel('Position','FontSize',16) 
