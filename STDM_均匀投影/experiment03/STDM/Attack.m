function y = Attack(x, type)

y = x;

if  strcmp(type, 'resize2')
    y = imresize(x, 2, 'bicubic');
    y = imresize(y, 1/2, 'bicubic');
end

if  strcmp(type, 'resize4')
    y = imresize(x, 4, 'bicubic');
    y = imresize(y, 1/4, 'bicubic');
end

if  strcmp(type, 'resize.5')
    y = imresize(x, 1/2, 'bicubic');
    y = imresize(y, 2, 'bicubic');
end

if  strcmp(type, 'resize.25')
    y = imresize(x, 1/4, 'bicubic');
    y = imresize(y, 4, 'bicubic');
end

if  strcmp(type, 'noise-gaussian')
    y = imnoise(x, 'gaussian', 0, 0.001); % mean:0, variance:0.001
end

if  strcmp(type, 'noise-salt&pepper')
    y = imnoise(x, 'salt & pepper', 0.001); % density:0.001
end

if  strcmp(type, 'noise-poisson')
    y = imnoise(x, 'poisson');
end

if  strcmp(type, 'filter-med')
    y = medfilt2(x);
end

if  strcmp(type, 'crop-center')
    sz = size(x);
    top = round(sz(1)/4 + 1);
    left = round(sz(2)/4 + 1);
    y = x(top + 1: sz(1) - top, left + 1 : sz(2) - left);
end


