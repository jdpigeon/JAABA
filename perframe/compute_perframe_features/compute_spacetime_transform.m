function imnorm = compute_spacetime_transform(im,x,y,theta,a,b,meana,meanb)

boxwidth2 = round(meanb*6);
boxheight2 = round(meana*3);

x1 = floor(max(1,x-a*3));
x2 = floor(min(size(im,2),x+a*3));
y1 = ceil(max(1,y-a*3));
y2 = ceil(min(size(im,1),y+a*3));
%[x1,x2,y1,y2] = ellipse_to_bounding_box(pos.x,pos.y,pos.a*2,pos.b*2,pos.theta);
% y1 = floor(y1);
% y2 = ceil(y2);
% x1 = floor(x1);
% x2 = ceil(x2);
imbb = im(y1:y2,x1:x2);

[nrcurr,nccurr,~] = size(imbb);
theta = theta+pi/2;
R = [cos(theta),-sin(theta),0
  sin(theta),cos(theta),0
  0,0,1];
scalex = meanb/b;
scaley = meana/a;
S = [scalex,0,0;0,scaley,0;0,0,1];
tform = maketform('affine',R*S);
%tform = maketform('affine',R);
imnorm = imtransform(imbb,tform,...
  'UData',[x1-x,nccurr-x+x1],...
  'VData',[y1-y,nrcurr-y+y1],...
  'XData',[-boxwidth2,boxwidth2],...
  'YData',[-boxheight2,boxheight2],...
  'FillValues',0,...
  'XYScale',1);

%   subplot(1,4,3);
%   imagesc(imnorm,[0,1]);
%   axis image;