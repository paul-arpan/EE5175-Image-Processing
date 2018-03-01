clear all
load 'stack.mat';
img = eval(['frame' sprintf('%.3d',15)]);
k= size(img,1);
q= size(img,2);
delta_d = 50.5;
d_mean=zeros(size(img));

im_stack = zeros(size(img,1),size(img,2),100);

for i = 1:100
    im_stack(:,:,i) = im2double(eval(['frame' sprintf('%.3d',i)]));
end
i=15;
ML = zeros(size(img,1),size(img,1),100);
for i = 1:100
    img = im2double(eval(['frame' sprintf('%.3d',i)]));
    IMG = padarray(img, [1,1]);
   
    for p = 1: size(img,1)
        for m = 1:size(img,2)
            a=1+p; b=1+m;         
            ML(p,m,i) = abs(2*IMG(a,b) - IMG(a-1,b) - IMG(a+1,b)) + abs(2*IMG(a,b) - IMG(a,b-1) - IMG(a,b+1));
        end
    end
end



N = 1; %Window
FinalSML = SML(ML,N, img);

for i = 1:size(FinalSML,1)
    for j = 1:size(FinalSML,2)
        y_gaussian = FinalSML(i,j,:);
        [max_value,max_index] = max(y_gaussian);
        if(max_index>1 && max_index<100)
            y = [y_gaussian(max_index-1), y_gaussian(max_index), y_gaussian(max_index+1)];
            x = [max_index-1,max_index,max_index+1]*delta_d;
            d_mean(i,j)=GaussianFit(y,x,delta_d);
            
        end
       
    end
end

figure(1)
surfl(d_mean)
colormap(white)
image_focused = zeros(size(img));

for i = 1:size(img,1)
    for j = 1:1:size(img,2)
        d = d_mean(i,j)/delta_d;
        floor_image=floor(d);
        ceil_image=ceil(d);
        if(floor_image>0 && ceil_image<101)
            image_focused(i,j) = (1.0 - (d - floor_image))*double(im_stack(i,j,floor_image)) + (1.0 - (ceil_image-d))*(im_stack(i,j,ceil_image));
        end
    end
end

figure;imshow(uint8(image_focused*255));


