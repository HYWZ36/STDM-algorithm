close all;
clc;
clear all;
I = imread('lena_1024.bmp');
% I = imread('lena.bmp');
% data = ones(1:10);
% data = zeros(1:10);
% data = randsrc(1, 1000, [0 1;0.5 0.5]);

d = imread('logo_64.bmp');
data = reshape(d, 1, 64 * 64);

delta = 50;
stg = STDMHide(I, data, delta);
f = psnr(I, stg);
fprintf(1, 'psnr:%f\n', f);
% imshow(stg);
imwrite(stg, 'lena_1024_hide.bmp');

msg = STDMDehide(stg, delta, length(data));

len = min([length(msg), length(data)]);
ebr = sum(abs(msg(1:len) - data(1:len))) / len;
fprintf(1, 'ebr:%f\n', ebr);
imshow(reshape(msg, 64, 64));

SS = Attack(stg, 'noise-poisson');
msg = STDMDehide(SS, delta, length(data));
len = min([length(msg), length(data)]);
ebr = sum(abs(msg(1:len) - data(1:len))) / len;
fprintf(1, 'attack: noise-poisson ebr:%f\n', ebr);

m = reshape(msg, [64, 64]);
subplot(1, 3, 1);imshow(d);title('mark');
subplot(1, 3, 2);imshow(m);title('recover');
subplot(1, 3, 3);imshow(xor(d, m));title('differ');


% attack
% add noise
SS = Attack(stg, 'noise-gaussian');
msg = STDMDehide(SS, delta, length(data));
len = min([length(msg), length(data)]);
ebr = sum(abs(msg(1:len) - data(1:len))) / len;
fprintf(1, 'attack: noise-gaussian ebr:%f\n', ebr);

m = reshape(msg, [64, 64]);
subplot(1, 3, 1);imshow(d);title('mark');
subplot(1, 3, 2);imshow(m);title('recover');
subplot(1, 3, 3);imshow(xor(d, m));title('differ');

% filter
SS = Attack(stg, 'filter-med');
msg = STDMDehide(SS, delta, length(data));
len = min([length(msg), length(data)]);
ebr = sum(abs(msg(1:len) - data(1:len))) / len;
fprintf(1, 'attack: filter-med ebr:%f\n', ebr);

m = reshape(msg, [64, 64]);
subplot(1, 3, 1);imshow(d);title('mark');
subplot(1, 3, 2);imshow(m);title('recover');
subplot(1, 3, 3);imshow(xor(d, m));title('differ');

% resize
SS = Attack(stg, 'resize4');
msg = STDMDehide(SS, delta, length(data));
len = min([length(msg), length(data)]);
ebr = sum(abs(msg(1:len) - data(1:len))) / len;
fprintf(1, 'attack: resize4 ebr:%f\n', ebr);

m = reshape(msg, [64, 64]);
subplot(1, 3, 1);imshow(d);title('mark');
subplot(1, 3, 2);imshow(m);title('recover');
subplot(1, 3, 3);imshow(xor(d, m));title('differ');

