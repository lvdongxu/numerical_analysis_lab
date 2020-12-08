function [T,h] = step_changing_trapezoid(f, x, a, b, e)
    h = b - a;
    T1 = h * (subs(f, x, a) + subs(f, x, b)) / 2;
    T2 = T1 / 2 + h / 2 * subs(f, x, a + h / 2);
    while abs(T2 - T1) >= e
        h = h / 2;
        T1 = T2;
        S = 0;
        x_i = a + h / 2;
        while x_i < b
            S = S + subs(f, x, x_i);
            x_i = x_i + h;
        end
        T2 = T1 / 2 + S * h / 2;
    end
    T = T2;
    
end