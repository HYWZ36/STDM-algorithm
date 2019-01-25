% v1.1:20141215 
% Change function from floor to round
function y = Quantificate(x, num, delta)
dither = (num * 2 - 1) * (delta / 4);%'(num * 2 - 1)' makes '0,1' to '-1, +1'
y = delta * round((x - dither) / delta) + dither;%v1.1
% y = delta * floor((x - dither) / delta) + dither;%v1.0
% y = delta * round((x + delta / 4) / delta) - delta / 4;
