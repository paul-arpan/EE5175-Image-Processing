H_21 = Sample('img1.pgm','img2.pgm');
H_23 = Sample('img3.pgm','img2.pgm');


IMG1 = imread('img1.pgm');
IMG2 = imread('img2.pgm');
IMG3 = imread('img3.pgm');


NumCanvasRows =  3*size(imread('img1.pgm'),1); 
NumCanvasColumns = 3* size(imread('img1.pgm'),2);

OffsetRow = 200;
OffsetColumn = 500;


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
        v1 = BilinearInterp(i1,j1,IMG1);
        v2 = BilinearInterp(i,j,IMG2);
        v3 = BilinearInterp(i3,j3,IMG3);
        if(Present(i1,j1,IMG1) && ~Present(i,j,IMG2) && ~Present(i3,j3,IMG3))
            canvas(ii,jj) = v1;
        elseif(~Present(i1,j1,IMG1) && ~Present(i,j,IMG2) && Present(i3,j3,IMG3))
            canvas(ii,jj) = v3;
        elseif(~Present(i1,j1,IMG1) && Present(i,j,IMG2) && ~Present(i3,j3,IMG3))
            canvas(ii,jj) = v2;
        elseif(~Present(i1,j1,IMG1) && Present(i,j,IMG2) && Present(i3,j3,IMG3))
            canvas(ii,jj) = 0.5*v2 + 0.5*v3;
        elseif(Present(i1,j1,IMG1) && Present(i,j,IMG2) && ~Present(i3,j3,IMG3))
            canvas(ii,jj) = 0.5*v1+0.5*v2;
        elseif(Present(i1,j1,IMG1) && ~Present(i,j,IMG2) && Present(i3,j3,IMG3))
            canvas(ii,jj) = 0.5*v1+0.5*v3;
        elseif(Present(i1,j1,IMG1) && Present(i,j,IMG2) && Present(i3,j3,IMG3))
            canvas(ii,jj) = 0.333333*v1+0.333333*v2+0.333333*v3;
        end
        
    end
end

imshow(uint8(canvas));