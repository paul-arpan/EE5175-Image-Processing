Img = imread('pisa_rotate.pgm');

theta = (3.99/180)*pi;

p = size(Img,1);
q = size(Img,2);

rot_img = 0* ones(p,q);

for i=1:p
    for j=1:q
        X = (i - p/2)*cos(theta) + sin(theta)*(j-q/2) + p/2;
        Y = -(i - p/2)*sin(theta) + cos(theta)*(j-q/2) + q/2;
        
        f_x=floor(X);
        f_y=floor(Y);
        c_x=f_x + 1;
        c_y=f_y + 1;
        if (f_x >=1 && f_y>=1 && f_x <=p && f_y<=q)
            rot_img(i,j) = rot_img(i,j)+  Img(f_x,f_y)*(c_x-X)*(c_y-Y);
        end
        
        if (c_x >=1 && f_y>=1 && c_x <=p && f_y<=q)
            rot_img(i,j) = rot_img(i,j)+  Img(c_x,f_y)*(X-f_x)*(c_y-Y);
        end
        
        if (c_x >=1 && c_y>=1 && c_x <=p && c_y<=q)
            rot_img(i,j) = rot_img(i,j)+  Img(c_x,c_y)*(X-f_x)*(Y-f_y);
        end
        
        if (f_x >=1 && c_y>=1 && f_x <=p && c_y<=q)
            rot_img(i,j) = rot_img(i,j)+  Img(f_x,c_y)*(c_x-X)*(Y-f_y);
        end
        
    end
end

figure,imshow(Img);
figure,imshow(uint8(rot_img));