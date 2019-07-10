

function nextS = func_getNextState(begS,net,func,j)
% j means to update the j-th gene
% net: 1x(ngenes*(ngenes+2^Kmax)))

global num_gene;
global Kmax;

maxNR = 2^Kmax;

% len_per_set = length(net)/num_gene;
% rule = net((j-1)*len_per_set+1 : j*len_per_set); % rule to update the j-th gene
% rule=input+func
input = net(1+(j-1)*num_gene : j*num_gene);
rule = func(1+(j-1)*maxNR : j*maxNR);

indp = find(input==1);
parent = begS(indp);
intP = getState2Int(parent,length(parent)); %length(parent): 1~3
newVal = rule(intP);

if(newVal==0.5)
%     r = rand(1);
%     if(r>=0.5)
%         newVal = 1;
%     else
%         newVal = 0;
%     end
    newVal = begS(j);  % stay unchanged
end

nextS = begS;
nextS(j) = newVal; % update the j-th gene


end %end of function