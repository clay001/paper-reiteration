
function [STG_data] = func_getSTG_forData(STG_all,data_all_new)

global num_celltype;

%     [nSmp,N] = size(data);
%     STG_data = zeros(nSmp,nSmp);
%     Dvals = zeros(nSmp,1);
%     for i=1:nSmp
%         vect = data(i,:); 
%         val = getState2Int(vect,N);
%         Dvals(i) = val;
%     end
    nSmp = size(data_all_new, 1)-num_celltype;
    STG_data = zeros(nSmp,nSmp);
    Dvals = data_all_new(num_celltype+1:end,1);
    Probs = data_all_new(num_celltype+1:end,2);
    for i=1:nSmp
        for j=1:nSmp
            STG_data(i,j) = STG_all(Dvals(i),Dvals(j)) *Probs(i)*Probs(j); % *Probs(i) or *Probs(i)*Probs(j)
%             STG_data(i,j) = STG_all(Dvals(i),Dvals(j)); %using unique data
        end
    end
    
end %end function