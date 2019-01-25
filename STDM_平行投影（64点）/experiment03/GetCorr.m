function r = GetCorr(x, y)
len = min(length(x(:)),length(y(:)));
x = double(x(1:len));
y = double(y(1:len));
mx = mean(x);
my = mean(y);
r = sum((x - mx).*(y - my)) /(sqrt(sum((x - mx).^2)) * sqrt(sum((y - my).^2)));

