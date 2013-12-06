function [ im_colorshaped, M, means_d ] = colorshape( im )

[x, y, z] = size(im);
h = x*y;
D = reshape(im, h, 3);
means_d = mean(D);
D_norm = double(D) - [ones(h,1)*means_d(1) ,ones(h,1)*means_d(2), ones(h,1)*means_d(3)];
C= D_norm'*D_norm;

[~, ~, M] = svd(C);
for f =1:h
   D_temp = D_norm(f, :);
   new_temp = (M*D_temp')';
   D_norm(f, :) = new_temp;
end

im_colorshaped = D_norm;

end

