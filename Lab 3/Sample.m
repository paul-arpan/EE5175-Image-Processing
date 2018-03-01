clear;
close all;
IMG = imread('Nautilus.pgm');

p = size(IMG,1);
q = size(IMG,2);

sigma = 1;
N = ceil(sigma*6 + 1);
gauss = zeros([N,N]);
for i = 1:N
    for j = 1:N
        gauss(i,j) = (i-N/2)^2 + (j-N/2)^2;
    end
end
        
if (N==1)
    gauss = 1;
else
    div = 1/(2*pi*sigma*sigma);
    gauss = -(gauss)/(2*sigma*sigma);
    gauss = exp(gauss)*div;
    gauss = gauss/sum(sum(gauss));
end

m = floor(N/2);

canvas = padarray(IMG, [m,m]);
final = zeros(size(canvas));


for i = 1:size(canvas,1)-N + 1
    for j = 1:size(canvas,2)-N + 1
        
        kernel = double(canvas(i:i+N-1,j:j+N-1)).*gauss;
        final(i+m,j+m) = sum(sum(kernel));
        
    end
end

final1 = final(m+1:p+m,m+1:q+m);
figure;imshow(IMG);
figure;imshow(uint8(final1));