function [ H ] = Homog( tx,ty,tz,rx,ry,rz,f,d )

K= [f 0 0;0 f 0;0 0 1];
t = [tx;ty;tz];
Rz = [cos(rz) -sin(rz) 0; sin(rz) cos(rz) 0; 0 0 1];
Ry = [cos(ry) 0 sin(ry) ; 0 1 0;-sin(ry) 0 cos(ry) ];
Rx = [1 0 0;0 cos(rx) -sin(rx) ;0 sin(rx) cos(rx) ];

R = Rx*Ry*Rz;
n=[0;0;1];

H = K*(R + t*n'/d)*inv(K);


end

