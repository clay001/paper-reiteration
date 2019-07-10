

function ConNet = func_getRandomStruture()

    global num_gene;
    global Kmax; % max inputs per gene
    
    % connectivity matrix
    ConNet = zeros(num_gene, num_gene);
    
    numP = 1+fix(rand(num_gene,1)*Kmax); % number of parents: 1~3
    
    for i=1:num_gene
        j=numP(i);
        nK = 1+fix(rand(j,1)*num_gene); % decide which are the parents (note: there may be duplicate numbers in nK, like 5,4,4)
        ConNet(nK,i)=1;
    end