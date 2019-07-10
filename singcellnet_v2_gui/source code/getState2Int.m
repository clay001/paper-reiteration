
function iB = getState2Int(Stat,N)
global bitValue;
n=length(Stat);
if(n~=N)
    disp('Wanning in getState2Int(): inconsistent number');
    disp(n);
    disp(N);
end

% % haifen's code
% iB = 0;
% weig = 2^(N-1);
% for i=1:N
%     iB = iB + Stat(i)*weig;
%     weig = weig/2;
% end
% iB = iB+1;

% Xiaomeng revised
iB = sum(bitValue(Stat(end:-1:1)==1))+1;
% if iB~=iB2
%     disp('Error');
% end



