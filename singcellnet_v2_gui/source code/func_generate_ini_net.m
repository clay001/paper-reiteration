
function [ini_net, ini_func, ini_score] = func_generate_ini_net(ntop, data_all_new)

    global num_gene;
    global Kmax; % max inputs per gene

    
    ini_net = zeros(ntop, num_gene*num_gene);
    ini_func = zeros(ntop, num_gene*2^Kmax);
    ini_score = [];
    for i = 1:ntop
        ConNet = func_getRandomStruture(); % num_gene x num_gene
        ini_net(i,:) =  reshape(ConNet,1,num_gene*num_gene);        
        
%         [score0,T, Func_vec] = func_getScoreForOneNetwork(ConNet, data_all,0);
%         [score1,T, Func_vec] = func_getScoreForOneNetwork(ConNet, data_all,1);
%         score = score0 + score1; 
        [score,Func_vec] = func_getScoreForOneNetwork(ConNet, data_all_new);
        ini_score = [ini_score; score];
        ini_func(i,:) = Func_vec;        
    end
    
end

