clear all;clc;close all;
trans_range = 10;
s_input = struct('V_POSITION_X_INTERVAL',[10 30],...%(m)
                 'V_POSITION_Y_INTERVAL',[10 30],...%(m)
                 'V_SPEED_INTERVAL',[0.2 2.2],...%(m/s)
                 'V_PAUSE_INTERVAL',[0 1],...%pause time (s)
                 'V_WALK_INTERVAL',[2.00 6.00],...%walk time (s)
                 'V_DIRECTION_INTERVAL',[-180 180],...%(degrees)
                 'SIMULATION_TIME',200,...%(s)
                 'NB_NODES',75);
             
s_mobility = Generate_Mobility(s_input);
nonodes = s_mobility.NB_NODES;
for i = 1:nonodes
    s_mobility.VS_NODE(i).ID = [];
    %s_mobility.VS_NODE(i).ID(end+1,1) = i;
    for j = 1: length(s_mobility.VS_NODE(i).V_TIME)
            s_mobility.VS_NODE(i).ID(j,1) = i;
    end
end
disp('Please wait, processing data');
 T = struct2table(s_mobility.VS_NODE);
 %T1 = table2array(T);
 %mat=[T{:}{:}];
%  
%
%
%
% Contact arnavbalyan1@gmail.com for the complete code with fulll implementation of blockchain.
%
%
%
%  arr = [];
%  arr11 = [];
%  data = [];
%  [m,n] = size(T);
%  for j = 1:m 
%     for i = 1:n
%          temp = T{j,i};
%          temp1 = cell2mat(temp);
%          arr = horzcat(arr,temp1);
%     end
%     data = vertcat(data,arr);
%     arr = [];
%  end
%  sorted_data = sortrows(data,1);
%  tracker = 1;
%  usedata = [];
%  for it = 1:length(sorted_data)
%     if(sorted_data(it,4) ==0 )
%         usedata(tracker,:) = sorted_data(it,:);
%         tracker = tracker+1;
%     end
%  end
% end
timeStep = 0.1;%(s)
test_Animate(s_mobility,s_input,timeStep);
disp('Finished')
clear('arr','arr11','i','it','j','m','n','T')
