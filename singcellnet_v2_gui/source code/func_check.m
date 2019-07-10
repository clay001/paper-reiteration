
function [child_net,Flag] = func_check(child_net)
% to check the #input<=Kmax; if not, remove some inputs
% child_net: 1 x (ngenes*ngenes)

% to improve: just need to check the part around "cut_point"

global num_gene;
global Kmax;
    
Flag = 0; % =1 means there are some #input > Kmax

for i=1:num_gene
    input = child_net((i-1)*num_gene+1 : i*num_gene);
    nump = sum(input);
    if(nump >3)
        Flag = 1;
        input = func_reduceInput(input, Kmax);
        child_net((i-1)*num_gene+1 : i*num_gene) = input;
    end
    % add @2014-Mar-7
    if(nump <=0)
        Flag = 1;
        input = func_addInput();
        child_net((i-1)*num_gene+1 : i*num_gene) = input;
    end
    
end

  
end