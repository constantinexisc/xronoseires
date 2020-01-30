clear all;
close all;

load('data.mat');

length_of_data = length(data);
new_data = zeros(length(data),1);

%parapeters for outbrake detection

window = 50;
step = 1;


%preallocate merory for the clise of data
take_a_slise_from_raw_data_past = zeros(window,1);
take_a_slise_from_raw_data_now = zeros(window,1);
data_log_past = zeros(window,1);
data_log_now = zeros(window,1);
pearson = zeros(1,1);
pearson_log = zeros(1,1);
frames_table = zeros(1000,2);


now = zeros(1,1);
now = 50;

%value = 1 becouse from table frames it is all outbrakes                                     
who_many_outbreaks = 1;

find_the_the_bountres = zeros(100,2);
flag = false;
count_variabel = 1;

new_data = abs(data);
data = new_data;

figure('Name','Raw data');
plot((1:length_of_data),new_data);
xlabel('Time','FontSize',16) 
ylabel('Piks','FontSize',16)

%pointer for frame table
j=1;

for i = window+1: step :length_of_data-window-1
    
    take_a_slise_from_raw_data_past = data(i-window:i-1);
    take_a_slise_from_raw_data_now = data(i-window+now:i-1+now);
    
    pearson = corr(take_a_slise_from_raw_data_now,take_a_slise_from_raw_data_past,'Type','Pearson');
    
    if(abs(pearson) < 0.3)
        continue;
        %printf('No outbreak abs peterson value %f',abs(pearson));
    else 
        %Logarifm the data
        data_log_past = log(take_a_slise_from_raw_data_past);
        data_log_now = log(take_a_slise_from_raw_data_now);
        pearson_log = corr(data_log_now,data_log_past,'Type','Pearson');
        if(abs(pearson_log) < 0.25)
            printf('Outbreak i = %d', i+now);
            %start frame
            frames_table(j,1) = i-window+now;
            frames_table(j,2) = i-1+now;
            j = j + 1;
            %figure;
            %plot((i-window+now:i-1+now),take_a_slise_from_raw_data_now);
            %break;
        end
        
    end

end

[frames_table,~,~]= reduseArray(frames_table); 


find_the_the_bountres(who_many_outbreaks,1) = frames_table(who_many_outbreaks,1);
%disting outbtake
for k = 1 : length(frames_table) - 1
    sub = frames_table(k+1,1) - frames_table(k,1);
    if(flag == true)
        find_the_the_bountres(who_many_outbreaks,1) = frames_table(k,1);
       flag = false; 
    end
    
    if( sub > 1000)%subjective it depend the length of data
        find_the_the_bountres(who_many_outbreaks,2) = frames_table(k,2);
        who_many_outbreaks = who_many_outbreaks + 1;
        flag = true;
    end
    
    if(k ==  length(frames_table) - 1  )
        find_the_the_bountres(who_many_outbreaks,2) = frames_table(k+1,2);
    end
end

[find_the_the_bountres,r,~]= reduseArray(find_the_the_bountres);

%plot the outbrakes 
name = 'Outbrack';
for p = 1 : r
    
    figure('Name',strcat(name,'_',int2str(p)));
    plot( (find_the_the_bountres(p,1):find_the_the_bountres(p,2)  ) , data(find_the_the_bountres(p,1):find_the_the_bountres(p,2)));

end

figure('Name','Results')
plot((1:length_of_data),data);
hold on;
for p = 1 :r
      plot( (find_the_the_bountres(p,1):find_the_the_bountres(p,2)  ) , data(find_the_the_bountres(p,1):find_the_the_bountres(p,2)),'r');
end  
hold off;
xlabel('Time','FontSize',16) 
ylabel('Force','FontSize',16) 
saveas(gcf,'alternative.pdf')
