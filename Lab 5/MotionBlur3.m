clear all;
load 'cam.mat'
f = 500;
d = 5000;
img = double(rgb2gray(imread('pillars.jpg')));

final2 = zeros(size(img));
Homograph = zeros([size(rx,2),3,3]);

for i = 1:size(rx,2)
    Homograph(i,:,:) = Homog(tx(1,i),ty(1,i),0,0,0,0,f,d);
end

figure; imshow(uint8(img));


    for i = 1:size(img,1)
        for j = 1:size(img,2)
           i1=0; j1=0;
            for k = 1:size(rx,2)
                %Homograph(k,:,:) = Homog(tx(1,k),ty(1,k),0,0,0,0,f,depth);
                temp = (reshape(Homograph(k,:,:),[3,3]))\[i;j;1];
                i1 = temp(1) / temp(3);
                j1 = temp(2) / temp(3);
                final2(i,j) = final2(i,j) + BilinearInterp(i1,j1,img);
            
            end
        
            final2(i,j) = final2(i,j)/size(rx,2);
        end
    end
    
figure; imshow(uint8(final2));



%close all;

