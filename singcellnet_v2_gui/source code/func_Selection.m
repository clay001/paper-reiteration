
function [top_score,top_net] = func_Selection(next_score,next_net, ntop)
% select ntop scores(and nets) from "next_score,next_net"

%     [C,IA,IC] = unique(next_net,'rows','stable'); %remove duplicate networks
%     Score = next_score(IA);    
%     [sortS,Ind] = sort(Score,'descend');
%     top_score = sortS(1:ntop);
%     top_net = C(Ind(1:ntop), :); 
    
    [sortS,Ind] = sort(next_score,'descend');
    top_score = sortS(1:ntop);
    top_net = next_net(Ind(1:ntop), :);    
    
end