function T = changed_trapezoid(f,a,b,e)
    if nargin~=4
        error('请输入需要求�?分的f、上界和下界以及�?差e')
    end
    h = b - a;
    T1 = h * (f(a) + f(b)) / 2;
    T2 = T1 / 2 + h / 2 * f(a + h / 2);
    while abs(T2 - T1) >= e
        h = h / 2;
        T1 = T2;
        S = 0;
        x = a + h / 2;
        while x < b
            S = S + f(x);
            x = x + h;
        end
        T2 = T1 / 2 + S * h / 2;
    end
    T = T2;