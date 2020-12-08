function I = Simpson(fun,a,b,n)
if nargin ~= 4
    error('请输入需要求积分的f、上界和下界和子区间数n')
end
h = (b - a) / n;
I = h / 6 * (fun(a) + fun(b) + 4 * fun(a + h / 2));
for i = 1:n-1
    I = I + h / 6 * (4 * fun(a + h * i + h / 2) + 2 * fun(a + h * i));
end
end