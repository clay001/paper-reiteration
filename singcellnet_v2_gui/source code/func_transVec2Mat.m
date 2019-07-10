

function conNet = func_transVec2Mat(net_inputs)
% conNet: one column is inputs for one gene

    global num_gene;

    len = length(net_inputs);
    % Ngene = sqrt(len);

    conNet = zeros(num_gene, num_gene);
    for i=1:num_gene
        vec = net_inputs((i-1)*num_gene+1 : i*num_gene);
        conNet(:,i) = vec';
    end
end