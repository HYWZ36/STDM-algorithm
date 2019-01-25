close all;
clc;
clear all;
I = imread('lena_1024.bmp');
d = imread('logo_64.bmp');
data = reshape(d, 1, 64 * 64);
delta = 20;
stg = STDMHide(I, data, delta);
f = psnr(I, stg);
fprintf(1, 'psnr:%f\n', f);
imwrite(stg, 'lena_1024_hide.bmp');
msg = STDMDehide(stg, delta, length(data));

len = min([length(msg), length(data)]);
ebr = sum(abs(msg(1:len) - data(1:len))) / len;
fprintf(1, 'ebr:%f\n', ebr);
m = reshape(msg, [64, 64]);
% subplot(1, 3, 1);imshow(d);title('mark');
% subplot(1, 3, 2);imshow(m);title('recover');
% subplot(1, 3, 3);imshow(xor(d, m));title('differ');

% add gaussian noise
SS = Attack(stg, 'noise-gaussian');
% subplot(1,2,1);imshow(stg);title('隐藏信息载体图');
% subplot(1,2,2);imshow(SS);title('经高斯攻击后载体图');
msg = STDMDehide(SS, delta, length(data));
len = min([length(msg), length(data)]);
ebr = sum(abs(msg(1:len) - data(1:len))) / len;
fprintf(1, 'attack: noise-gaussian ebr:%f\n', ebr);

m = reshape(msg, [64, 64]);
% subplot(1, 3, 1);imshow(d);title('mark');
% subplot(1, 3, 2);imshow(m);title('recover');
% subplot(1, 3, 3);imshow(xor(d, m));title('differ');

% resize
SS = Attack(stg, 'resize2');
% subplot(1,2,1);imshow(stg);title('隐藏信息载体图');
% subplot(1,2,2);imshow(SS);title('经缩放攻击后载体图');
msg = STDMDehide(SS, delta, length(data));
len = min([length(msg), length(data)]);
ebr = sum(abs(msg(1:len) - data(1:len))) / len;
fprintf(1, 'attack: resize4 ebr:%f\n', ebr);

m = reshape(msg, [64, 64]);
% subplot(1, 3, 1);imshow(d);title('mark');
% subplot(1, 3, 2);imshow(m);title('recover');
% subplot(1, 3, 3);imshow(xor(d, m));title('differ');
