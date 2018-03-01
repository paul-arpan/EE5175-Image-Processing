Img_centre = imread('IMG_centre.jpg');
Img_centre = imresize(Img_centre,0.2);
imwrite(Img_centre,'img_centre.pgm');
Img_centre = imread('img_centre.pgm');

Img_left = imread('IMG_left.jpg');
Img_left = imresize(Img_left,0.2);
imwrite(Img_left,'img_left.pgm');
Img_left = imread('img_left.pgm');

Img_right = imread('IMG_right.jpg');
Img_right = imresize(Img_right,0.2);
imwrite(Img_right,'img_right.pgm');
Img_right = imread('img_right.pgm');


H_21 = Sample('img_left.pgm','img_centre.pgm');
H_23 = Sample('img_right.pgm','img_centre.pgm');

NumCanvasRows =  3*size(Img_centre,1); 
NumCanvasColumns = 4* size(Img_centre,2);

OffsetRow = 500;
OffsetColumn = 1000;


canvas = zeros(NumCanvasRows,NumCanvasColumns);
for jj = 1:NumCanvasColumns
    for ii = 1:NumCanvasRows
        i = ii - OffsetRow;
        j = jj - OffsetColumn;
        tmp = H_21 * [i;j;1];
        i1 = tmp(1) / tmp(3);
        j1 = tmp(2) / tmp(3);
        
        tmp = H_23 * [i;j;1];
        i3 = tmp(1) / tmp(3);
        j3 = tmp(2) / tmp(3);
        v1 = BilinearInterp(i1,j1,Img_left);
        v2 = BilinearInterp(i,j,Img_centre);
        v3 = BilinearInterp(i3,j3,Img_right);
        if(Present(i1,j1,Img_left) && ~Present(i,j,Img_centre) && ~Present(i3,j3,Img_right))
            canvas(ii,jj) = v1;
        elseif(~Present(i1,j1,Img_left) && ~Present(i,j,Img_centre) && Present(i3,j3,Img_right))
            canvas(ii,jj) = v3;
        elseif(~Present(i1,j1,Img_left) && Present(i,j,Img_centre) && ~Present(i3,j3,Img_right))
            canvas(ii,jj) = v2;
        elseif(~Present(i1,j1,Img_left) && Present(i,j,Img_centre) && Present(i3,j3,Img_right))
            canvas(ii,jj) = 0.5*v2 + 0.5*v3;
        elseif(Present(i1,j1,Img_left) && Present(i,j,Img_centre) && ~Present(i3,j3,Img_right))
            canvas(ii,jj) = 0.5*v1+0.5*v2;
        elseif(Present(i1,j1,Img_left) && ~Present(i,j,Img_centre) && Present(i3,j3,Img_right))
            canvas(ii,jj) = 0.5*v1+0.5*v3;
        elseif(Present(i1,j1,Img_left) && Present(i,j,Img_centre) && Present(i3,j3,Img_right))
            canvas(ii,jj) = 0.333333*v1+0.333333*v2+0.333333*v3;
        end
        
    end
end



figure;imshow(uint8(canvas));