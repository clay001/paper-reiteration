
function [STG_final] = func_getSTG_Ntimes(net,func, signalType)
% net,func -------- row vectors!

%     global signalType;
    global ntimes;
    global num_gene;
    NS = 2^num_gene;
    
    %%%% signal %%%%--------------------------
    sg = 4;  %%% send signal to the 4th gene (Fgfr2)!!
    %sg = 1; %16C, Cdx2

    
    %A = zeros(NS,NS);    
    STG_1 = zeros(NS,NS); 
    for i=1:NS
        begS = getInt2State(num_gene,i);
        newS = begS; 
       % if(signalType==2 && t==1)
        if(signalType==2)
            newS(sg) = 0;  %%% send signal to the 4th gene!!
        end
        for t=1:ntimes      % ntimes=10
            j = 1+fix(rand(1)*5);    % update each node asynchronously and uniformly
            nextS = func_getNextState(newS,net,func,j);
            nS = getState2Int(nextS,num_gene);
            STG_1(i,nS) = STG_1(i,nS)+1;
        end
    end        
    %A = A+STG_1;
    %end
    A = STG_1;
    
    STG_final = zeros(NS,NS);
    for i=1:NS
        STG_final(i,:) = A(i,:)/sum(A(i,:));
    end
end

