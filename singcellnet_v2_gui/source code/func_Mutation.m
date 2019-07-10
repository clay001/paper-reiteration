

function [mut_score,mut_net, mut_netpos] = func_Mutation(cro_net,cro_score,prob_mut,data_all_new)

    % global num_gene;
    % global ntimes;
%     global num_celltype;
% 
%     data = data_all(num_celltype+1:end,:);
%     typeNum = data_all(1:num_celltype,1);
global num_mut_per_genome;

%     num_mut_per_genome = 1; % one-point mutation
    
    [r,c] = size(cro_net);
    num_mut = floor(r*prob_mut)+1; % minial 1; in this case it is 1
    
    %after mutation result
    mut_score = cro_score;
    mut_net = cro_net;

    mut_netpos = [];

    new_genome = zeros(1,c);
    
    for i=1:num_mut
       indx = ceil(rand()*r); % randomly pick a network
       
       %generate random position to mutate
        rand_pos = [];
        while size(rand_pos,1)~=num_mut_per_genome
            temp = floor(rand()* c ) + 1; %in case of 0 ----mutation position
            if ~any(rand_pos==temp) && temp<= c
                new_genome = mut_net(indx,:);
                new_genome(temp) = 1 - new_genome(temp);
                
                new_genome = func_check(new_genome);
                mut_net(indx,:) = new_genome;
                rand_pos = [rand_pos;temp];
                
                mut_netpos = [mut_netpos; [indx, temp]]; %record the mutated network and positionb
                
%                 if func_check(new_genome) % pass
%                     mut_net(indx,temp) = 1 - mut_net(indx,temp); %make it oposite ----- (row=index, col=temp)
%                     rand_pos = [rand_pos;temp];
%                 end
            end
        end        
        
       net_i = mut_net(indx, :);
       %score:   
       conNet = func_transVec2Mat(net_i);
       score = func_getScoreForOneNetwork(conNet, data_all_new);
       mut_score(indx) = score;
%        [score0,T0] = func_getScoreForOneNetwork(conNet, data_all, 0);
%        [score1,T1] = func_getScoreForOneNetwork(conNet, data_all, 1);
%        mut_score(indx) = score0+score1; 
       
%        Func = func_getFunctions(net_i); % num_gene x (2^Kmax)
%        Func_vec = reshape(Func',1,num_gene*2^Kmax);
%        TransMat = func_getSTG_Ntimes(net_i,Func_vec);
%        T = func_getSTG_forData(TransMat,data); 
%        mut_score(indx) = func_getScore(T, typeNum);   
       
       %write to original matrix
       
    end 
    
    
    
end %end function
    
    
    
    