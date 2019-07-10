


function Res_score = func_getScore(T,Nums,signalType)
    
% %% haifen's code
% % global signalType;
%     nICM = Nums(1);   
%     nPE = Nums(2);   
%     nEPI = Nums(3);       
%     
%     Res_score = 0;
%     
% %     if signalType==2
% %         toICM = T(:,1:nICM);
% %         toPE = T(:,nICM+1:nICM+nPE);
% %         toEPI = T(:,nICM+nPE+1:nICM+nPE+nEPI);
% %         Res_score = sum(sum(toPE)) - sum(sum(toICM)) - 2*sum(sum(toEPI));
% %         return;
% %     end
%     
%     
% %     if signalType==1 % no signal (new scoring)
% %         toICM = T(:,1:nICM);
% %         toPE = T(:,nICM+1:nICM+nPE);
% %         toEPI = T(:,nICM+nPE+1:nICM+nPE+nEPI);
% %         PE2EPI = T(nICM+1:nICM+nPE,nICM+nPE+1:nICM+nPE+nEPI);
% %         EPI2PE = T(nICM+nPE+1:nICM+nPE+nEPI, nICM+1:nICM+nPE);
% %         score1 = sum(sum(toPE))+sum(sum(toEPI)) - sum(sum(toICM));
% %         score1 = score1 - sum(sum(PE2EPI)) - sum(sum(EPI2PE));
% %         
% %         % find attractors, if no attractor in PE or EPI, imposing penalty!
% %         Bonus_attractor = 1;
% %         score_PE = 0;
% %         score_EPI = 0;
% %         ind_attractor = func_findAttractor(T); %-- findAttractor
% %         for i=1:length(ind_attractor)
% %             indx = ind_attractor(i);
% %             if(indx>nICM && indx<=nICM+nPE)
% %                 score_PE = Bonus_attractor;
% %             end
% %             if(indx>nICM+nPE && indx<=nICM+nPE+nEPI)
% %                 score_EPI = Bonus_attractor;
% %             end
% %         end
% %         
% %         score2 = score_PE + score_EPI;
% %         if(score2 < length(Nums)-1)
% %             Res_score = score1/length(Nums); %penalty
% %         else
% %             Res_score = score1;
% %         end
% %         %Res_score = score_PE + score_EPI;
% %         return;
% %     end
%     
% 
%     if signalType==0   % scoring when no signals           
%         bon_1 = 1;      % bonus for ICM self-transition
%         bon_2 = 0.2;    % PE or EPI self-transition
%         pos_tran = 3; % positive transition
%         pen_back = -2;  % penalty for back-transition
%         pen_sibl = -3;  % penalty for sibling-transition
% 
% 
%         % self-transition
%         mat_ICM = T(1:nICM, 1:nICM);
%         mat_PE = T(nICM+1:nICM+nPE, nICM+1:nICM+nPE);
%         mat_EPI = T(nICM+nPE+1:nICM+nPE+nEPI, nICM+nPE+1:nICM+nPE+nEPI);
%         % positive transition
%         mat_ICM2PeEPI = T(1:nICM, nICM+1:nICM+nPE+nEPI);
%         % back transition
%         mat_PeEPI2ICM = T(nICM+1:nICM+nPE+nEPI, 1:nICM);
%         % trans-transition
%         mat_PE2EPI = T(nICM+1:nICM+nPE, nICM+nPE+1:nICM+nPE+nEPI);
%         mat_EPI2PE = T(nICM+nPE+1:nICM+nPE+nEPI, nICM+1:nICM+nPE);
% 
% 
%         score = 0;
%         score = score + bon_1 * sum(sum(mat_ICM));
%         score = score + bon_2 * sum(sum(mat_PE));
%         score = score + bon_2 * sum(sum(mat_EPI));
%         score = score + pos_tran * sum(sum(mat_ICM2PeEPI));
%         score = score + pen_back * sum(sum(mat_PeEPI2ICM));
%         score = score + pen_sibl * sum(sum(mat_PE2EPI));
%         score = score + pen_sibl * sum(sum(mat_EPI2PE));
%         %%% return
%         Res_score = score; 
% %         return;
%     end
%% xiaomeng's code
    global scorematrix
%     disp('XM')
    cnum = [0; cumsum(Nums)];
    transPro = zeros(length(Nums));
    for i = 1:length(Nums)
        for j = 1:length(Nums)
            transPro(i,j) = sum(sum(T(cnum(i)+1:cnum(i+1), ...
            cnum(j)+1:cnum(j+1))));
        end
    end
    Res_score = sum(sum(scorematrix.*transPro));
%     if abs(score - score2) > 1e-6
%         disp('error');
%     end
end


    

    









    
    
    