

function outputv = func_getOutputBySimpleRule(tar, vec, Sta)
% vec: a vector where 1 denotes parent
% Sta: state for the parents (000~111 for #parents=3)
% tar: target gene (1-bit)

    global GeneRelation; %[1;-1;1;-1;-1];

    outputv = 0;
    

    %ind1 = find(vec==1);     %parents = vec(ind1);
    ind1 = find(vec~=0);
    Relation = GeneRelation(ind1);
    Relation = GeneRelation(tar) * Relation; %the relation between target and inputs(parents)
    jdg = Sta*Relation; % combine effect of inputs
    
    
    
    if sum(Sta)==0 % all zeros
        outputv = 0;   
        if Relation<0
            outputv = 1; %if no inhibit, then activated
        end
        return;
    end
    
    if(jdg<0)
        outputv = 0;
%         if(~isempty(find(ind1==tar, 1))) % include self-loop
%             %jdg = jdg+1; % add more weights to self-loop
%             outputv = 0.5;
%         end
    elseif(jdg==0)
        outputv = 0.5;
    elseif(jdg>0)
        outputv = 1;
    end
    
%     switch(jdg)
%         case -3
%             outputv = 0;
%         case -2
%             outputv = 0;
%         case -1
%             outputv = 0;
%         case 0
%             outputv = 0.5;
%         case 1
%             outputv = 1;
%         case 2
%             outputv = 1;
%         case 3
%             outputv = 1;
%         otherwise
%             disp('Warning: Unknown value in func_getOutputBySimpleRule');
%     end

end
