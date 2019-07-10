
function ini_score = func_setIni_score(ini_net, ini_func, data_all)
% ini_net: ntop x (num_gene*(num_gene+2^Kmax))


    % global ntimes;
    % global num_gene;
    global num_celltype;


    data = data_all(num_celltype+1:end,:);
    typeNum = data_all(1:num_celltype,1);

    ini_score = [];
    % N = size(data,2);
    for i=1:size(ini_net)

        TransMat = func_getSTG_Ntimes(ini_net(i,:), ini_func(i,:));  %% func_getSTG_all
        TransMat = TransMat^100;  %%%
        T = func_getSTG_forData(TransMat, data);     
        score = func_getScore(T, typeNum); 

        ini_score = [ini_score; score];
    end

end