Img = imread('cells_scale.pgm');
scale = 0.8;

p = size(Img,1);
q = size(Img,2);

scale_img = 0* ones(p,q);

for i=1:p
    for j=1:q
        X = (i - p/2)/scale + p/2;
        Y = (j - q/2)/scale + q/2;
        f_x=floor(X);
        f_y=floor(Y);
        c_x=f_x + 1;
        c_y=f_y + 1;
        if (f_x >=1 && f_y>=1 && f_x <=p && f_y<=q)
            scale_img(i,j) = scale_img(i,j)+  Img(f_x,f_y)*(c_x-X)*(c_y-Y);
        end
        
        if (c_x >=1 && f_y>=1 && c_x <=p && f_y<=q)
            scale_img(i,j) = scale_img(i,j)+  Img(c_x,f_y)*(X-f_x)*(c_y-Y);
        end
        
        if (c_x >=1 && c_y>=1 && c_x <=p && c_y<=q)
            scale_img(i,j) = scale_img(i,j)+  Img(c_x,c_y)*(X-f_x)*(Y-f_y);
        end
        
        if (f_x >=1 && c_y>=1 && f_x <=p && c_y<=q)
            scale_img(i,j) = scale_img(i,j)+  Img(f_x,c_y)*(c_x-X)*(Y-f_y);
        end
        
    end
end

figure, imshow(Img)
figure, imshow(uint8(scale_img))