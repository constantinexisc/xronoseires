clear all;
close all;

load('data.mat');

figure('Name','Sismologika')
plot((1:length(data)),data);
xlabel('Time','FontSize',16) 
ylabel('Force','FontSize',16) 

length_of_data = length(data);
data = abs(data);

window = 200;
step = 50;
now = 50;

integer_div  = rem(window,(1:window));

threshole = 0.99;
threshole_log = 0.01;
gama_array_past = zeros(window,1);

take_a_slise_from_raw_data_past = zeros(window,1);


for i = window+1: step :15000 %length_of_data-window-1
    
    take_a_slise_from_raw_data_past = data(i-window:i-1);
    
    for v = 1 : window
       gama_array_past(v) = VarianceFunction(v,take_a_slise_from_raw_data_past);
    end
    
    person = corr((1:window)',gama_array_past);
    printf('Pearson  Var%f',person);
    
%     figure('Name', 'Variance fanction');
%     subplot(2,1,1)
%     plot((1:window),gama_array_past);
%     title('Variance fanction');
%     
%     subplot(2,1,2)
%     plot(log(1:window),log(gama_array_past));
%     title('Log Variance fanction');
    
    person_log = corr((1:window)',log(gama_array_past));
    printf('Pearson Log var%f',person_log);
    
    %[graphType, slope, intercept, MSE, R2, S] = logfit((1:window),gama_array_past);
    %printf('Graph type %s and i = %d ', graphType,i);
    printf(' and i = %d ', i);
%     pause(3);
%     close 'Variance fanction';
    if(abs(person_log) > threshole)
       log_signal_window = log(take_a_slise_from_raw_data_past);
       
       person_signal = corr((1:window)',log_signal_window);
       printf('LOG SIGNAL COOR %f',person_signal);
       if (abs(person_signal)<threshole_log)
           printf('Out brake in i = %d and %f',i,person_signal);
           break;
       end
    end
end


