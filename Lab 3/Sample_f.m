IMG = imread('Nautilus.pgm');

p = size(IMG,1);
q = size(IMG,2);
A=2.0;
B=6184.60;

SIG = zeros([p,q]);
for i = 1:p
    for j = 1:q
        SIG(i,j) = 1;
    end
end

N  = ceil(6*SIG + 1);

for i = 1: size(N,1)
    for j = 1:size(N,2)
        if (mod(N(i,j),2) == 0)
            N(i,j) = N(i,j)+1;
        end
    end
end

canvas = padarray(IMG, [3,3]);
final = zeros(size(IMG));



for i = 1:p
    for j = 1:q
        a = i+3; b = j+3;
        sigma = SIG(i,j);
        div = double(1/(2*pi*sigma*sigma));
        
        gauss = zeros([N(i,j),N(i,j)]);
        for m = 1:N(i,j)
            for n = 1:N(i,j)
                gauss(m,n) = (m-N(i,j)/2)^2 + (n-N(i,j)/2)^2;
            end
        end
        
        
        gauss = -(gauss)/double(2*sigma*sigma);
        gauss = exp(gauss)*div;
        
        if(gauss == zeros([N(i,j),N(i,j)]))
            gauss = ones([N(i,j),N(i,j)]);
        end
        
        gauss = gauss/sum(sum(gauss));
        
        if(N(i,j)==1)
            gauss = 1;
        end
        
        kernel = double(canvas(a - floor(N(i,j)/2) : a + floor(N(i,j)/2),b - floor(N(i,j)/2) : b + floor(N(i,j)/2))).*gauss;
        final(i,j) = sum(sum(kernel));

        
    end
end

figure;imshow(IMG);
figure;imshow(uint8(final));