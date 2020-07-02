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
%  target(1).x = [];
%  target(1).y = [];
%  target(1).nodeno = [];
%  flag = 0;
%  identify = -1;
% for i = 1:length(usedata)
%     time1 = usedata(i,1);
%     nodeid = usedata(i,6);
%     cnt = 1;
%     target(i).host = nodeid;
%     target(i).hostx = usedata(i,2);
%     target(i).hosty = usedata(i,3);
%     for j = 1:length(data)
%         if (data(j,6)~=identify)
%             flag = 0;
%         end
%         if(data(j,6) ~= nodeid && flag == 0)
%             flag = 1;
%             if(data(j,1)<time1)
%                 continue
%             else
%                 target(i).nodeno(cnt) =  data(j,6);
%                 prevtime = data(j,1);
%                 prevxloc = data(j,2);
%                 prevyloc = data(j,3);
%                 prevxspeed = data(j,4);
%                 prevyspeed = data(j,5);
%                 usetime = time1 - prevtime;
%                 target(i).x(cnt) = ((usetime * prevxspeed) + prevxloc);
%                 target(i).y(cnt) = ((usetime * prevyspeed) + prevyloc);
%                 cnt = cnt +1;
%             end
%         end
%         identify = data(j,6);
%     end
% end
% for i=1:1:length(target)% to find the neighbour node in network 
%      cnp = 1;
%     for j=1:1:length(target(i).x)
%          ab = (target(i).hostx - target(i).x(j));
%          bc = (target(i).hosty - target(i).y(j));
%          dis=sqrt((ab)^2 + (bc)^2 );
%          if(dis<=trans_range)
%              target(i).neighbour(cnp)=target(i).nodeno(j);
%              cnp = cnp+1;
%          end
%     end     
% end
% for i = 1:nonodes
%     TN(i).id=target(i).host;
%     TN(i).cond=1;	
%     TN(i).rop=0;	
%     TN(i).neighbour=target(i).neighbour;  
%     TN(i).cnt = 1;
%     TN(i).vect=struct('Prev_Hash',{},'Timestamp',{},'Data',{},'Hash',{});
%     TN(i).vect(1).Prev_Hash = 0;
%     TN(i).vect(1).Timestamp = datestr(now,'mm dd, yyyy HH:MM:SS.FFF ');
%     TN(i).vect(1).Data = target(i).host;
%     strr = strcat(mat2str(TN(i).vect(1).Prev_Hash),mat2str(TN(i).vect(1).Timestamp),mat2str(TN(i).vect(1).Data));
%     
%     hasher = System.Security.Cryptography.SHA256Managed;
%     hash0 = uint8(hasher.ComputeHash(uint8(strr)));
%     TN(i).vect(1).Hash = dec2hex(hash0);
% end
% for i = 1:length(target)
%     SN(i).id=target(i).host;
%     SN(i).cond=1;	
%     SN(i).rop=0;	
%     SN(i).neighbour=target(i).neighbour;  
%     SN(i).cnt = 1;
%     SN(i).vect=struct('Prev_Hash',{},'Timestamp',{},'Data',{},'Hash',{});
%     SN(i).vect(1).Prev_Hash = 0;
%     SN(i).vect(1).Timestamp = datestr(now,'mm dd, yyyy HH:MM:SS.FFF ');
%     SN(i).vect(1).Data = target(i).host;
%     strr = strcat(mat2str(SN(i).vect(1).Prev_Hash),mat2str(SN(i).vect(1).Timestamp),mat2str(SN(i).vect(1).Data));
%     
%     hasher = System.Security.Cryptography.SHA256Managed;
%     hash0 = uint8(hasher.ComputeHash(uint8(strr)));
%     SN(i).vect(1).Hash = dec2hex(hash0);
% end
% 
% for i=1:length(target)
%    for j= 1: length(SN(i).neighbour)
%    if(TN(SN(i).neighbour(j)).cond==1)
%                 xc = SN(i).id;
%                 %disp(xc)
%                 pth = TN(xc).cnt;
%                     for p = 1: pth
%                         flag = 1;
%                         counter = 0;
%                         xp = SN(i).neighbour(j);
%                         nth  = TN(xp).cnt;
%                         for q = 1: nth
%                             if TN(xc).vect(p).Data == TN(xp).vect(q).Data
%                                 flag = 2;
%                             end
% 
%                         end
%                         if flag == 1
%                             TN(xp).cnt = TN(xp).cnt + 1;
%                             TN(xp).vect(TN(xp).cnt).Prev_Hash = TN(xp).vect(TN(xp).cnt - 1).Hash;
%                             TN(xp).vect(TN(xp).cnt).Timestamp = datestr(now,'mm dd, yyyy HH:MM:SS.FFF '); 
%                             TN(xp).vect(TN(xp).cnt).Data = TN(xc).vect(p).Data;
%                             finalstr = strcat(mat2str(TN(xp).vect(TN(xp).cnt).Prev_Hash),mat2str(TN(xp).vect(TN(xp).cnt).Timestamp),mat2str(TN(xp).vect(TN(xp).cnt).Data));
%                             hashObject = System.Security.Cryptography.SHA256Managed;
%                             hash1 = uint8(hashObject.ComputeHash(uint8(finalstr)));
%                             TN(xp).vect(TN(xp).cnt).Hash = dec2hex(hash1);
%                             %SN(SN(i).neighbour(j)).cnt = SN(SN(i).neighbour(j)).cnt + 1;
% 
%                         end
%                     end
%    end
%    end
% end
timeStep = 0.1;%(s)
test_Animate(s_mobility,s_input,timeStep);
disp('Finished')
clear('arr','arr11','i','it','j','m','n','T')
