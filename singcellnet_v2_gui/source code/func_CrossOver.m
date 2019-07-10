

function [cro_score,cro_net,cro_exinds] = func_CrossOver(curr_net,curr_score,data_all_new,total_score,cro_times)


    %num_cro = length(cro_ind);
    num_cro = size(curr_net,1); %=ntop
    tolal_times = num_cro*cro_times;

    cro_score = [];
    cro_net = [];
    cro_exinds = [];

    while (size(cro_net,1) <  tolal_times)     % ~=num_cro: why only num_cro crossover-samples?
        % two parents
        r0 = 0; r1 = 0;

        r =  rand()*0.2*total_score ;
        summ = 0;
        summ = summ + curr_score(1); %cro_ind(1)
        for i=1:num_cro
            if summ<r     %toadd: || (summ<0 && r<0 && summ>r), in case negative scores
                summ = summ + curr_score(i); %cro_ind(i)
            else
                r0 = i; %cro_ind(i)------------ r0
                break;
            end
        end

        r = rand()*total_score ; %abs( rand()-0.5 ) %then most likely that r1>r0
%         r = rand()*0.2*total_score ;
        summ = 0;
        summ = summ + curr_score(1); %cro_ind(1)
        for i=1:num_cro
            %if summ<r || r0==r1
            if summ<r || r0==i
                summ = summ + curr_score(i); %cro_ind(i)
            else
                r1 = i; %cro_ind(i)------------ r1
                break;
            end
        end

        %cro_exinds = [cro_exinds;[r0, r1]]; %------------ record for test

        % generate new children
        parent1_net = curr_net(r0,:);
        parent2_net = curr_net(r1,:);

        % swap
        cut_point = floor(length(parent1_net)*rand());
        cro_exinds = [cro_exinds;[r0, r1, cut_point]]; %------------ record for test

        child1_net = [parent1_net(1:cut_point), parent2_net(cut_point+1 : length(parent1_net))];
        child2_net = [parent2_net(1:cut_point), parent1_net(cut_point+1 : length(parent1_net))];

        child1_net = func_check(child1_net);
        child2_net = func_check(child2_net);


        cro_net = [cro_net; child1_net; child2_net];

        %score:      
        conNet1 = func_transVec2Mat(child1_net);
        conNet2 = func_transVec2Mat(child2_net);
        score1 = func_getScoreForOneNetwork(conNet1, data_all_new);
        score2 = func_getScoreForOneNetwork(conNet2, data_all_new);
%         [score1_0,T1_0] = func_getScoreForOneNetwork(conNet1, data_all, 0);
%         [score1_1,T1_1] = func_getScoreForOneNetwork(conNet1, data_all, 1);
%         score1 = score1_0 + score1_1;
%         [score2_0,T2_0] = func_getScoreForOneNetwork(conNet2, data_all,0);
%         [score2_1,T2_1] = func_getScoreForOneNetwork(conNet2, data_all,1);
%         score2 = score2_0 + score2_1;
        
%         Func1 = func_getFunctions(child1_net); % num_gene x (2^Kmax)
%         Func_vec1 = reshape(Func1',1,num_gene*2^Kmax);
%         TransMat1 = func_getSTG_Ntimes(child1_net,Func_vec1);    
%         T1 = func_getSTG_forData(TransMat1,data);     
%         score1 = func_getScore(T1, typeNum);    
% 
%         Func2 = func_getFunctions(child2_net); % num_gene x (2^Kmax)
%         Func_vec2 = reshape(Func2',1,num_gene*2^Kmax);
%         TransMat2 = func_getSTG_Ntimes(child2_net,Func_vec2);    
%         T2 = func_getSTG_forData(TransMat2,data);     
%         score2 = func_getScore(T2, typeNum); 

        cro_score = [cro_score; score1; score2];

    end %end of while
 

end %end function

    
    
    
    
