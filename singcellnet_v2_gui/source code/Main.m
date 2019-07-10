
%% xiaomeng added

global bitValue;
global ExpFileName BenchmarkNetFileName;
global populationSize;
% ExpFileName = 'data_ICMPeEPI_5genes_unique.txt';
% BenchmarkNetFileName = 'benchmark_ICMPeEPI_5genes.txt';
bitValue = zeros(1, 32);
for i = 1:32
    bitValue(i) = 2^(i-1);
end
%% 
global num_gene;
global num_celltype;
%global typeNum;
global Kmax; % max inputs per gene
global ntimes;  % for PBN
global GeneRelation;
global prob_mut ntop num_GA;
%global signalType;

%signalType = 1; % 1: ICM->PE
% GeneRelation = [1;-1;1;-1;-1]; % can be inferred from correlations
% GeneRelation = [-1;-1;1;1;1]; %16C

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% test data (columns: Cdx2,Em,O4,Ng,S2,G6,F4,F2,G4)
% data_all = importdata('data_ICMPeEPI_5genes_unique.txt'); % Ng,G6,F4,F2,G4
data_all = importdata(ExpFileName); % Ng,G6,F4,F2,G4
num_celltype = 3;
num_gene = 5;
Kmax = 3;
%typeNum = data_all(1:num_celltype,1);


%%%%%%%%% parameters: 
% ntimes = 100; 
num_Paral = 1;
% num_GA = 1; %50 #generation, or running times of GA
% ntop = 100; % select ntop for each population
num_eli = 0; % numbers of elite
num_cro = ntop - num_eli; % numbers of individuals for crossover
cro_times = populationSize/ntop;
prob_mut = 0.01; % mutation rate default 0.001


option = 3; %1: unique state; 2: duplicate states with numbers; 3: duplicate with probabilities
data_all_new = func_transformData(data_all,option); %%%note!

% Ben = importdata('benchmark_ICMPeEPI_5genes.txt');
if ~isempty(BenchmarkNetFileName)
    Ben = importdata(BenchmarkNetFileName);
    [ben_score] = func_getScoreForOneNetwork(Ben, data_all_new);
end

Scores_all = [];   
Network_all = [];
Fmeasures = zeros(ntop,num_GA);

Network_sum = zeros(1,num_gene*num_gene);
sum_times = 0;
for para = 1:num_Paral
%%% initializtion
[ini_net, ini_func, ini_score] = func_generate_ini_net(ntop, data_all_new); % generate ntop random networks (ini_net: ntop x (ngenes*(ngenes+2^Kmax)))
%ini_score = func_setIni_score(ini_net, ini_func, data_all); % calculate the scores of ini_net
[curr_score,curr_net] = func_Selection(ini_score,ini_net,ntop);

highScore_begin = 0;
    for iter = 1:num_GA     

        curr_score_tran = func_tranScore(curr_score);
       %curr_score_tran = curr_score - min(curr_score); % transform the scores so that there is no negative value
       total_score = sum(curr_score_tran(num_eli+1 : num_eli+num_cro)); % total_score


       %%% run for elite, crossover, mutation
       next_score = [];
       next_net = [];
       next_param = [];


       %%% elite
       eli_score = curr_score(1:num_eli);
       eli_net = curr_net(1:num_eli,:);  
       % directly pass to next generation
       next_score = [next_score; eli_score]; 
       next_net = [next_net; eli_net];


       %%% crossover
    %     [cro_score,cro_net] = func_CrossOver(cro_ind,curr_net,curr_score,data_all,total_score,cro_times);   
        [cro_score,cro_net, cro_exinds] = func_CrossOver(curr_net,curr_score_tran,data_all_new,total_score,cro_times);   
          
        %%% mutation
        [mut_score,mut_net, mut_netpos] = func_Mutation(cro_net,cro_score,prob_mut,data_all_new);
  

        % pass to next generation
        next_score = [next_score; mut_score]; 
        next_net = [next_net; mut_net];


        %%% Selection
    %     [curr_score,curr_net] = func_Selection(next_score,next_net,ntop);
        [C,IA,IC] = unique(next_net,'rows','stable'); %remove duplicate networks
        Sc = next_score(IA);
        if(length(Sc)>=ntop)
            [curr_score,curr_net] = func_Selection(Sc,C,ntop);
        else
            disp('Warning: not enough unique networks!'); %not happen
            [curr_score,curr_net] = func_Selection(next_score,next_net,ntop); %used to be
        end

        % topest
        topest_net = curr_net(1, :);
        topest_score = curr_score(1);

        Scores_all = [Scores_all,curr_score]; % one column for one generation
        Network_all = [Network_all; curr_net]; 


        % F-measure
        if ~isempty(BenchmarkNetFileName)
            Fmeasures_i = func_getFm(curr_net,Ben);
            Fmeasures(:,iter) = Fmeasures_i;  % one column for one generation

        end
        
        if(highScore_begin>0)
            Network_sum = Network_sum + sum(curr_net); %-----------------------------------------------
            sum_times = sum_times + 1;
        end
        %if(highScore_begin==0 && max(curr_score)-min(curr_score)<0.00001)
        %if(highScore_begin==0 && max(curr_score)-min(curr_score)<0.001*curr_score(1)/10)
        if(highScore_begin==0 && max(curr_score)-min(curr_score)<0.01*curr_score(1))
            highScore_begin = iter;
        end
        
        % check for running
        disp([para iter]);        
        

    end
    
    
end %in parallel

if(sum_times>0)   
    Network_infer = Network_sum/(sum_times*100);
    inferNet = reshape(Network_infer,num_gene,num_gene);
    % netfilename = strcat('Network_infer_', int2str(cn), '.csv');
    % csvwrite(netfilename, inferNet);

    thr = max(max(inferNet))/2;
    ind0 = find(inferNet<thr);
    ind1 = find(inferNet>=thr);
    inferNet(ind0) = 0;
    inferNet(ind1) = 1;
    if ~isempty(BenchmarkNetFileName)
        [Pre, Sen, Fm] = getFmeasure(Ben, inferNet);   
        inferNet_Res = [Pre, Sen, Fm];
    end
    % inferNet_Res = [inferNet_Res; [Pre, Sen, Fm]];
end

disp(inferNet);
%     Mean_score = mean(Scores_all);
%     Medn_score = median(Scores_all);
%     Mean_Fm = mean(Fmeasures);
%     Medn_Fm = median(Fmeasures);
% 
%     figure;
%     subplot(2,1,1),  plot(Mean_score); hold on; plot(Medn_score,'r'); 
%     legend('Mean','Median');
%     xlabel('Iteration');ylabel('Score');
%     hold on;
%     subplot(2,1,2), plot(Mean_Fm); hold on; plot(Medn_Fm,'r');hold off;
%     legend('Mean','Median');
%     xlabel('Iteration');ylabel('F-measure');








   
