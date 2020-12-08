function I = trapezoid(fun,a,b,n)
if nargin ~= 4
    error('请输入需要求积分的f、上界和下界和子区间数n')
end
h = (b - a) / n;
I = h / 2 * (fun(a) + fun(b));
for i = 1:n-1
    I = I + h / 2 * 2 * fun(a + h * i);
end
end