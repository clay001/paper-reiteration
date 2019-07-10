
function Fmeasures = func_getFm(net_inputs, Ben)
% net_inputs: each row correspond to one net

    % global num_gene;

    numNet = size(net_inputs,1);
    Fmeasures = zeros(numNet,1);
    for i=1:numNet
        net = net_inputs(i,:);
        conNet = func_transVec2Mat(net);
        Fmeasures(i) = getFmeasure(Ben, conNet);    
    end

end



