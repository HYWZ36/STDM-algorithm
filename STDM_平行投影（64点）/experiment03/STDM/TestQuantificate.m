delta = 2;
% a = [0:2:10];
a = [0:0.1:10];
a0 = Quantificate(a, 0, delta);
a1 = Quantificate(a, 1, delta);
% [a;a0;a1]
plot(a, a0, 'r*', a, a1, 'ko');

n = 0.2;
c = a0 + n;
c0 = Quantificate(c, 0, delta);
c1 = Quantificate(c, 1, delta);
plot(a, c0, 'r*', a, c1, 'ko', a, c, 'bd');