Img= imread('lena_translate.pgm');

t_x = 3.75;
t_y = 4.3;

p = size(Img,1);
q = size(Img,2);

trans_img = 0* ones(p,q);

for i=1:p
    for j=1:q
        X = i - t_x;
        Y = j - t_y;
        f_x=floor(X);
        f_y=floor(Y);
        c_x=f_x + 1;
        c_y=f_y + 1;
        if (f_x >=1 && f_y>=1 && f_x <=p && f_y<=q)
            trans_img(i,j) = trans_img(i,j)+  Img(f_x,f_y)*(c_x-X)*(c_y-Y);
        end
        
        if (c_x >=1 && f_y>=1 && c_x <=p && f_y<=q)
            trans_img(i,j) = trans_img(i,j)+  Img(c_x,f_y)*(X-f_x)*(c_y-Y);
        end
        
        if (c_x >=1 && c_y>=1 && c_x <=p && c_y<=q)
            trans_img(i,j) = trans_img(i,j)+  Img(c_x,c_y)*(X-f_x)*(Y-f_y);
        end
        
        if (f_x >=1 && c_y>=1 && f_x <=p && c_y<=q)
            trans_img(i,j) = trans_img(i,j)+  Img(f_x,c_y)*(c_x-X)*(Y-f_y);
        end
        %trans_img(i+floor(t_x), j+floor(t_y)) = Img(i,j)*(1-a)*(1-b) + Img(i-1,j)*(a)*(1-b) + Img(i,j-1)*(1-a)*(b) + Img(i-1,j-1)*(a)*(b);
    end
end
%J = imtranslate(Img,[3.75,4.3]);

figure, imshow(uint8(trans_img));
figure, imshow(Img);
