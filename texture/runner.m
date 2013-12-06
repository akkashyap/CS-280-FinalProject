im_texture = imread('texture1.jpg'); 
[w, h, ~] = size(im_texture);
[im, M, means_d] = colorshape(im_texture);

%break into three components one for red blue and green

im_r = reshape(im(:,1), w, h);
im_g = reshape(im(:,2), w, h);
im_b = reshape(im(:,3), w, h);

%match them separately 
imGray = rgb2gray(im_texture);


out_r = reshape(matchTexture(randi([0 255], 300, 300), im_r, 4, 5), 297*297, 1);

out_g = reshape(matchTexture(randi([0 255], 300, 300), im_g, 4, 5), 297*297, 1);
out_b = reshape(matchTexture(randi([0 255], 300, 300), im_b, 4, 5), 297*297, 1);
inv_M = M^-1;
out_im = zeros(297*297, 3);
for i = 1:297*297
    temp_vector = (inv_M*[out_r(i) , out_g(i), out_b(i)]')';
    out_im(i, :) = temp_vector + means_d;
end

out_im = reshape(out_im, 297, 297, 3);
imagesc(out_im./255);
