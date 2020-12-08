function [y, T] = Romberg(f, x, a, b, e)
    T = 0;
    h = b - a;
    T(1,1) = h/2 * (subs(f, x, a) + subs(f, x, b));
    T(2,1) = comt(f, x, a, b, 2);
    T(2,2) = 4/3 * T(2,1) - 1/3 * T(1,1);
    
    i = 2;
    while (abs(T(i,i) - T(i-1, i-1)) > e)
        i = i + 1;
        T(i,1) = comt(f, x, a, b, 2^(i-1));
        for j = 2 : i
            T(i,j) = 4^j / (4^j-1) * T(i,j-1) - 1/(4^j-1) * T(i-1, j-1);
        end

    end
    
    y = T(i,i);
    T = T(1:i, 1:i);
end