function [ out_im ] = matchHistogram( im1, im2 )
% im1 should be noise and im2 should be the texture
out_im = zeros(size(im1));

im1_cdf = makeCDF(im1);
im2_cdf = makeCDF(im2);

[rows, cols] = size(out_im);
for i = 1:rows
    for j = 1:cols
        out_im(i,j) = InvCDFLookup(im2_cdf, CDFLookup(im1_cdf, im1(i,j)+1)) - 1;
    end
end
end

function [cdf] = makeCDF(im)
h = myHist(im);
sum = 0;
cdf = zeros(size(h));
for i=1:length(h)
    sum = h(i) + sum;
    cdf(i) = sum;
end
end

function [out] = InvCDFLookup(cdf, value)
for i = 1:length(cdf)
    if abs(cdf(i) - value) < .000001
        out = i;
        return;
    elseif cdf(i) > value && i == 1
        out = 1; % not sure if this is the right way to handle this edge case
        %keyboard;
        return;
    elseif cdf(i) > value && cdf(i-1) <= value
        out = (value-cdf(i-1))*(1/(cdf(i)-cdf(i-1)))+(i-1);
        return;
    elseif i == length(cdf)
        keyboard;
    end
end
end

function [out] = CDFLookup(cdf, value)
before = floor(value);
if value == before
    out = cdf(value);
else
    after = ceil(value);
    if before < 0 || after < 0 || value > 255
        keyboard;
    end
    m = cdf(after)-cdf(before);
    out = m*(value - before) + cdf(before);
end
end

function [histo] = myHist(im)
im = reshape(im, 1, []);
im = floor(im);
histo = zeros(1,256);
for i = 1:256
    histo(i) = sum(im == i-1); 
end
histo = histo/length(im);
end
