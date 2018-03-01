
load 'cam.mat'
f = 500;
d = 1000;
img = double(rgb2gray(imread('pillars.jpg')));

MAT = [tx' ty' tz' rx' ry' rz'];

AA = unique(MAT,'rows');
ww = zeros([size(AA,1),1]);

for i = 1: size(AA,1)
    k = 0;  
    for q = 1:size(MAT,1)
        if(AA(i,:) == MAT(q,:))
            k = k + 1;
        end   
    ww(i) = k;
    end 
end
ww = ww/sum(ww);


final = zeros(size(img));
Homograph = zeros([size(AA,1),3,3]);
for i = 1:size(AA,1)
    Homograph(i,:,:) = Homog(AA(i,1),AA(i,2),AA(i,3),AA(i,4),AA(i,5),AA(i,6),f,d);
end

for i = 1:size(img,1)
    for j = 1:size(img,2)
        
        i1=0; j1=0;
        for k = 1:size(AA,1)
    
            temp = (reshape(Homograph(k,:,:),[3,3]))\[i;j;1];
            i1 = (temp(1) / temp(3));
            j1 = (temp(2) / temp(3));
            final(i,j) = final(i,j) +  ww(k) * BilinearInterp(i1,j1,img);
            
        end
        
    end
end


figure; imshow(uint8(img));
figure; imshow(uint8(final));


SUM = ((final1) - (final));
SUM = SUM.*SUM;
MSE = sum(sum(SUM))/(size(SUM,1)*size(SUM,2));
