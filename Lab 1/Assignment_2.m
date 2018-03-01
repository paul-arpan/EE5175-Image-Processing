% After solving the correspondence, we get 4 equations of affine transform

tx =5.6;
ty = 155.6;

theta = -0.5226;

Img = imread('IMG1.pgm');
Result = imread('IMG2.pgm');
p = size(Img,1);
q = size(Img,2);

%canvasing the image
temp=zeros(size(Result));
temp(1:p,1:q)=Img;
Img=temp;

p = size(Img,1);
q = size(Img,2);

transform_img = 0* ones(size(Result));

for i=1:p
    for j=1:q
        X = (i-tx)*cos(theta) + sin(theta)*(j-ty) ;
        Y = -(i-tx)*sin(theta) + cos(theta)*(j-ty) ;
        
        f_x=floor(X);
        f_y=floor(Y);
        c_x=f_x + 1;
        c_y=f_y + 1;
        
        if (f_x >=1 && f_y>=1 && f_x <=p && f_y<=q)
            transform_img(i,j) = transform_img(i,j)+  Img(f_x,f_y)*(c_x-X)*(c_y-Y);
        end
        
        if (c_x >=1 && f_y>=1 && c_x <=p && f_y<=q)
            transform_img(i,j) = transform_img(i,j)+  Img(c_x,f_y)*(X-f_x)*(c_y-Y);
        end
        
        if (c_x >=1 && c_y>=1 && c_x <=p && c_y<=q)
            transform_img(i,j) = transform_img(i,j)+  Img(c_x,c_y)*(X-f_x)*(Y-f_y);
        end
        
        if (f_x >=1 && c_y>=1 && f_x <=p && c_y<=q)
            transform_img(i,j) = transform_img(i,j)+  Img(f_x,c_y)*(c_x-X)*(Y-f_y);
        end
        
    end
end

figure, imshow(Result)
figure, imshow(uint8(Img))
figure, imshow(uint8(transform_img))

changes = (Result - uint8(transform_img) );
figure, imshow(changes)
