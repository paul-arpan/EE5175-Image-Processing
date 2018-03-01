clear all;
load 'cam.mat'
f = 500;
d = 1000;
img = double(rgb2gray(imread('pillars.jpg')));

final1 = zeros(size(img));

Homograph = zeros([size(rx,2),3,3]);
for i = 1:size(rx,2)
    Homograph(i,:,:) = Homog(tx(1,i),ty(1,i),tz(1,i),rx(1,i),ry(1,i),rz(1,i),f,d);
end



for i = 1:size(img,1)
    for j = 1:size(img,2)
        
        i1=0; j1=0;
        for k = 1:size(rx,2)
    
            temp = (reshape(Homograph(k,:,:),[3,3]))\[i;j;1];
            i1 = temp(1) / temp(3);
            j1 = temp(2) / temp(3);
            final1(i,j) = final1(i,j) + BilinearInterp(i1,j1,img);
            
        end
        
        final1(i,j) = final1(i,j)/size(rx,2);
    end
end


figure; imshow(uint8(img));
figure; imshow(uint8(final1));
