
% transform the data with 2 columns: 1st column contains the unique states; 
%2nd column are the corresponding probabilities of the states

function data_all_new = func_transformData(data_all,options)

    global num_celltype;
    
    data = data_all(num_celltype+1:end,:);
    typeNum = data_all(1:num_celltype,1);
    sumN = sum(typeNum);

    uniStateProb = [];
    Nums = zeros(num_celltype,1);    

    [nSmp,N] = size(data);
    Dvals = zeros(nSmp,1);
    
    for i=1:nSmp
        vect = data(i,:); 
        val = getState2Int(vect,N);
        Dvals(i) = val;
    end

    k=1;
    for i=1:num_celltype
        num = typeNum(i);
        vals = Dvals(k:k+num-1);
        %unv = unique(vals,'stable');
        unv = unique(vals); %------------ not 'stable' is ok, and..
        Nums(i,1)=length(unv);        
        %a = [unv, histc(vals,unv)/num]; % --- histc requires monotonically non-decreasing values
        if(options==1)
            a = [unv, ones(size(unv))]; %unique states
        elseif(options==2)
            a = [unv, histc(vals,unv)]; %duplicate states with numbers
        elseif(options==3)
            a = [unv, histc(vals,unv)/sumN]; % the prob should be  
        end        
        uniStateProb = [uniStateProb;a];
        k = k+num;
    end
    
    data_all_new = [[typeNum, Nums]; uniStateProb]; %the first num_celltype (i.e. 3) values are numbers of cell types
end



