function [ Final ] = SML( ML, N, img )
N = floor(N/2);
MML = padarray(ML,[N,N,0]);
Final=zeros(size(ML));

for i = 1:100
    for l = 1: size(img,1)
        for m = 1:size(img,2)
            a=N+l;b=N+m;
            sum = 0;
            
            for p = a-N:a+N
                for q = b-N:b+N
                    sum = sum + MML(p,q,i);
                end
            end
            
            Final(l,m,i) = sum;
            
        end
    end
    
    
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here


end

