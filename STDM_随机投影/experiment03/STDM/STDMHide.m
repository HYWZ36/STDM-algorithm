function o = STDMHide(I, data, delta)

block = [8, 8];
si = size(I);
lend = length(data);
N = floor(si(2) / block(2));%there are N blocks in each row
M = min(floor(si(1) / block(1)), ceil(lend / N));%there are M block in each colomn
o = I;
idx = 1;
bStop = false;

%v1 = ones(1, block(1) - 1);
%v1 = v1 / Magnitude(v1);%produce projection vector
rand('seed',0);v1=round(rand(1,8)*10);
v1 = v1 / Magnitude(v1);

for i = 0 : M - 1
    
    if bStop
        break;
    end
    rst = i * block(1) + 1;
    red = (i + 1) * block(1);

    for j = 0 : N - 1
        
        cst = j * block(2) + 1;
        ced = (j + 1) * block(2);
        tmp = I(rst:red, cst:ced);
        tmp = dct2(double(tmp));
        x = [];
        %副对角线
        for k = block(1):-1:1
            m = block(1) +1 - k;%makes position for diagnal coiefficients           
            x = [x,tmp(k, m)];
        end;
        
        p = sum(x.*v1);%the projection of the vector to be modulated
        v = x - p * v1;
        p = Quantificate(p, data(idx), delta);
        x = v + p * v1;
        %副对角线        
        for k = block(1):-1:1
            m = block(1) +1 - k;%makes position for diagnal coiefficients           
            tmp(k, m) = x(m);
        end;
        
        o(rst:red, cst:ced) = idct2(tmp);
        idx = idx + 1;
        if(idx > lend)
            bStop = true;
            break;
        end;
    end;
end;
