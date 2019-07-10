
function [score,Func_vec] = func_getScoreForOneNetwork(Net, data_all_new)
% Net should be a connectivity matrix
% signalType=0: no signal; 1: ICM->PE

    global num_gene;
    global Kmax;
    global num_celltype;
    
    nM = 100; %number of multiplications on STG; original is 100
    

%     data = data_all(num_celltype+1:end,:);
    typeNum = data_all_new(1:num_celltype,2); %1 is numbers with duplicate; 2 is numbers with unique

    Func = func_getFunctions(Net); % num_gene x (2^Kmax)

    Ben_vec =  reshape(Net,1,num_gene*num_gene);
    Func_vec = reshape(Func',1,num_gene*2^Kmax);
    
    
    %%% score1:
%     signalType = 2; % with signals
%     TransMat = func_getSTG_Ntimes(Ben_vec, Func_vec, signalType);  %%
%     TransMat100 = TransMat^100;
%     T100 = func_getSTG_forData(TransMat100, data); 
%     score1 = func_getScore(T100, typeNum, signalType);
%     score = score1;
    

    %%% score2:
    signalType = 0; % no signals
    TransMat = func_getSTG_Ntimes(Ben_vec, Func_vec, signalType);  %%
%     TransMat100 = TransMat^100;
    TransMat100 = TransMat^nM;
    T100 = func_getSTG_forData(TransMat100, data_all_new); 
    score2 = func_getScore(T100, typeNum, signalType);      
    score = score2;
    


end









