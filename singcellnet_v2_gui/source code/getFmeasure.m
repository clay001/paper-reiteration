
% compare two matrix which are connectivity matrixes of networks
% reture F-measure

function [Pre, Sen, Fm] = getFmeasure(ben, net)

    Res1=net+ben;
    tp=size(find(Res1==2),1);  %2!
    tn=size(find(Res1==0),1);  %0!
    Res2=net-ben;
    fp=size(find(Res2==1),1);  %1
    fn=size(find(Res2==-1),1); %-1

    if(tp+fp ~=0)
        Pre=tp/(tp+fp);
    else
        Pre=0;
    end
    if(tp+fn ~=0)
        Sen=tp/(tp+fn); %sensitivity, recall
    else
        Sen=0;
    end
    %     Spe=tn./(tn+fp); % specificity

    if(Pre+Sen ~=0)
        Fm=2*(Pre*Sen)/(Pre+Sen);
    else
        Fm=0;
    end

end


