clear all;
load 'cam.mat'
f = 1000;
d = 500;
img = double(rgb2gray(imread('pillars.jpg')));

final2 = zeros(size(img));
Homograph = zeros([size(rx,2),3,3]);

for i = 1:size(rx,2)
    Homograph(i,:,:) = Homog(0,0,0,rx(1,i),ry(1,i),0,f,d);
end

figure(1); imshow(uint8(img));


    for i = 1:size(img,1)
        for j = 1:size(img,2)
           i1=0; j1=0;
            for k = 1:size(rx,2)
                %Homograph(k,:,:) = Homog(0,0,0,rx(1,k),ry(1,k),0,focus,d);
                temp = (reshape(Homograph(k,:,:),[3,3]))\[i;j;1];
                i1 = temp(1) / temp(3);
                j1 = temp(2) / temp(3);
                final2(i,j) = final2(i,j) + BilinearInterp(i1,j1,img);
            
            end
        
            final2(i,j) = final2(i,j)/size(rx,2);
        end
    end
    
figure(2); imshow(uint8(final2));


