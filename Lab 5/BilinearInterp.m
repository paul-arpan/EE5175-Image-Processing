
function [ V ] = BilinearInterp( X , Y, Img )
V=0;
p = size(Img,1);
q = size(Img,2);

f_x=floor(X);
f_y=floor(Y);
c_x=f_x + 1;
c_y=f_y + 1;
if (f_x >=1 && f_y>=1 && f_x <=p && f_y<=q)
    V = V +  Img(f_x,f_y)*(c_x-X)*(c_y-Y);
end
if (c_x >=1 && f_y>=1 && c_x <=p && f_y<=q)
    V = V+  Img(c_x,f_y)*(X-f_x)*(c_y-Y);
end
    
if (c_x >=1 && c_y>=1 && c_x <=p && c_y<=q)
    V = V+  Img(c_x,c_y)*(X-f_x)*(Y-f_y);
end
        
if (f_x >=1 && c_y>=1 && f_x <=p && c_y<=q)
    V = V+  Img(f_x,c_y)*(c_x-X)*(Y-f_y);
end
end
% 
% function interp_value=BilinearInterp(i,j,I)
%     m=size(I,2);
%     n=size(I,1);
%     b=i-floor(i);
%     a=j-floor(j);
%     int_x=floor(i);
%     int_y=floor(j);
%     interp_value=0;
%         if(int_x+1<=m && int_y+1<=n && int_x>=1 && int_y>=1)
%             interp_value=I(int_y,int_x)*(1-a)*(1-b)+I(int_y+1,int_x)*a*(1-b)+I(int_y,int_x+1)*(1-a)*b+I(int_y+1,int_x+1)*a*b;
%         elseif(int_x==0 && int_y==0)
%             interp_value=I(int_y+1,int_x+1)*a*b;
%         elseif(int_x==0 && int_y==n)
%              interp_value=I(int_y,int_x+1)*(1-a)*b;
%         elseif(int_x==m && int_y==n)
%             interp_value=I(int_y,int_x)*(1-a)*(1-b);
%         elseif(int_x==m && int_y==0)
%             interp_value=I(int_y+1,int_x)*(1-b)*a;
%         elseif(int_x==0 && int_y>=1 && int_y+1<=n)
%             interp_value=I(int_y,int_x+1)*(1-a)*b+I(int_y+1,int_x+1)*a*b;
%         elseif(int_x>=1 && int_y==0 && int_x+1<=m)
%             interp_value=I(int_y+1,int_x)*(1-b)*a+I(int_y+1,int_x+1)*a*b;
%         elseif(int_x>=1 && int_y==n && int_x+1<=m)
%             interp_value=I(int_y,int_x)*(1-b)*(1-a)+I(int_y,int_x+1)*b*(1-a);
%         elseif(int_x==m && int_y>=1 && int_y+1<=n)
%             interp_value=I(int_y,int_x)*(1-b)*(1-a)+I(int_y+1,int_x)*a*(1-b);
%         end
%     
% end
% 
