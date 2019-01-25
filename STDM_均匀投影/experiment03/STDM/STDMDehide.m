function o = STDMDehide(I, delta, len)

block = [8, 8];
si = size(I);
N = floor(si(2) / block(2));%there are N blocks in each row
M = floor(si(1) / block(1));%there are M block in each colomn
o = [];
idx = 1;
bStop = false;

v1 = ones(1, block(1));
v1 = v1 / Magnitude(v1);%produce projection vector

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
        for k = block(1) :-1:1  
            m = block(1) +1- k;%makes position for diagnal coiefficients
            x = [x, tmp(k, m)];
        end;
        
        p = sum(x.*v1);
        q00 = Quantificate(p, 0, delta);
        q10 = Quantificate(p, 1, delta);
        [val, pos] = min(abs(p - [q00, q10]));
        if pos == 1
            o(idx) = 0;
        else
            o(idx) = 1;
        end;
 
         idx = idx + 1;
        if(idx > len)
            bStop = true;
        end;
    end;
end;
