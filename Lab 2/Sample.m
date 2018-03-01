function [ H ] = Sample( IMG1,IMG2 )

%Returns homomography of 2 on 1. That is H21


[corresp1, corresp2] = sift_corresp(IMG1, IMG2);
num=0;
m=0;
while (num<=0.8*size(corresp1,1))
num = 0;
m=m+1;

[H, corresp]= homography(corresp1,corresp2); 
for i=1:size(corresp1,1)
    if(i==corresp(1))||(i==corresp(2))||(i==corresp(3))||(i==corresp(4))
        continue
    end
    Corr = H * [corresp2(i,1);corresp2(i,2);1];
    Corr = Corr/Corr(3,1);
    
    thresh= sqrt((Corr(1,1)-corresp1(i,1))^2 + (Corr(2,1)-corresp1(i,2))^2);
    if thresh<=10
        num=num+1;
    end
        
end

num
end
end

    
    
