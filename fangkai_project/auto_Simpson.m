function I = auto_Simpson(fun,a,b,e)
if nargin ~= 4
    error('请输入需要求积分的f、上界和下界以及误差e')
end
h = (b - a);
S = h / 6 * (fun(a) + fun(b) + 4 * fun((a + b) / 2));
h = h / 2;
S1 = h / 6 * (fun(a) + fun(a + h) + 4 * fun(a + h / 2));
S2 = h / 6 * (fun(a + h) + fun(b) + 4 * fun(a + 3 * h / 2));
if abs(S - S1 - S2) < e
    I = S1 + S2 + (S1 + S2 - S) / 15;
else I = auto_Simpson(fun,a,(a + b) / 2,e/2) + auto_Simpson(fun,(a + b) / 2,b,e/2);
end
end