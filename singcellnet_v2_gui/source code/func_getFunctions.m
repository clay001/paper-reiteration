

function Funcs = func_getFunctions(ConNet)
% ConNet is a connectivity matrix!

    global num_gene;
    global Kmax; % max inputs per gene

    Funcs = zeros(num_gene, 2^Kmax); 
    for i=1:num_gene
        vec = ConNet(:,i);    
        nP = sum(vec); % number of parents (<=3)
        nB = 2^nP; % number of bits for nP
        for j=1:nB
            iSta = getInt2State(nP,j);
            Funcs(i, j) = func_getOutputBySimpleRule(i, vec, iSta);
        end    

    %     maxv = 2^(nB);
    %     randv = 1+fix(rand(1,1)*maxv);
    %     bStr = getInt2State(nB,randv); % int -> binary string
    %     Funcs(i, 1:nB) = bStr;
    end

end

