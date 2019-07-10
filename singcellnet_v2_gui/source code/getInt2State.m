

function stat = getInt2State(N,B)
% B: the int to be transformed; B is 1~2^N

stat = [];
K1=B-1;
for jj=N:-1:1
    mk = 2^(jj-1);
    s1 = floor(K1/mk);
    stat = [stat, s1]; %get string 00000~11111
    K1 = mod(K1, mk);
end
    