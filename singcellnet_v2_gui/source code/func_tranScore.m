
function curr_score_tran = func_tranScore(curr_score)

    maxs = max(curr_score);
    mins = min(curr_score);

    if(mins > 0)
        curr_score_tran = curr_score; %no change
        return;
    end
    if(maxs > 0)
        curr_score_tran = curr_score - mins;
    else
        curr_score_tran = curr_score + abs(mins) +1;
    end

end