function [keys,beats] = CreateBeats(n)
% index=find(n>0);
% n=n(index);
[M_n,N_n]=size(n);
% x=n(end-9:end);
x=zeros(1,9);
n=[n,x];
keys=[];
beats=[];
i=1;
while i<=N_n
    j=1;
    while j<N_n
        if n(i)==n(i+j)
            j=j+1;
        else 
            break
        end
    end

    if j<10
        keys=[keys,n(i)];
        i=i+j;
        if j==1
            beats=[beats,1/8];
        elseif j==2
            beats=[beats,1/4];
        elseif j==3||j==4||j==5
            beats=[beats,1/2];
        else
            beats=[beats,1];
        end
    else 
        keys=[keys,n(i)];
        beats=[beats,1];
        i=i+8;
    end
    
end

end