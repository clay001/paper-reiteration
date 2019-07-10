

function input = func_reduceInput(input, Kmax)
% reduce the input so that #input<=Kmax

sump = sum(input);
while(sump > Kmax)
    ind = find(input==1);
    len = length(ind);
    r = 1+fix(rand(1)*len);
    input(ind(r)) = 0;
    
    sump = sum(input);
end