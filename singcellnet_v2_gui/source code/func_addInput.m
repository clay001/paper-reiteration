
% when there is no inputs for a gene, add inputs
function input = func_addInput()
    global num_gene;
    global Kmax;
    
    input = zeros(1,num_gene); %row vector
    
    numP = 1+fix(rand(1)*Kmax); % number of parents: 1~3
    nK = 1+fix(rand(1,numP)*num_gene); % decide which are the parents (note: there may be duplicate numbers in nK, like 5,4,4)
    input(nK)=1;
    
end