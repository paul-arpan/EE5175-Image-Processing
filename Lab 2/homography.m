function [ H, corresp ] = homography( corresp1,corresp2 )

corresp = zeros(4,1);
for i = 1:4
    corresp(i)= randi([1,size(corresp1,1)],1);
end

X=zeros(size(corresp,1),2);
X1=zeros(size(corresp,1),2);


for i=1:size(corresp,1)
    X(i,:) = corresp2(corresp(i),:);
    X1(i,:) = corresp1(corresp(i),:);
end
A= zeros(2*size(corresp,1),9);

for i=1:2:2*size(corresp,1)
    j= (i+1)/2;
    A(i,:) = [-X(j,1), -X(j,2), -1, 0, 0, 0, X(j,1)*X1(j,1), X(j,2)*X1(j,1),X1(j,1)];
    A(i+1,:) = [0,0,0, -X(j,1), -X(j,2), -1,X(j,1)*X1(j,2),X(j,2)*X1(j,2),X1(j,2)];
end

MM=null(A);
%disp(size(MM))
%if(size(MM,2)==3)
%    A
%    MM
%end


H = reshape(MM(:,1),[3,3]).';


end

