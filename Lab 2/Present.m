function [ bool ] = Present( i , j , IMG )

if(i>=1 && i<=size(IMG,1) && j>=1 && j<=size(IMG,2))
    bool = true;
else
    bool = false;

end

