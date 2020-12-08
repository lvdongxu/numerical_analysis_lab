function I = Romberg(fun,a,b,e)
if nargin ~= 4
    error('请输入需要求积分的f、上界和下界以及误差e')
end
k = 0; 
n = 1; 
h = b - a;
T(1,1) = h / 2 * (fun(a) + fun(b));
d = b - a;
while e <= d
    k = k + 1;
    h = h / 2;
    sum = 0;
    for i = 1:n
        sum = sum + fun(a + (2 * i - 1) * h);
    end
    T(k+1,1) = T(k,1) / 2 + h * sum;
    for j = 1:k
        T(k + 1,j + 1) = T(k + 1,j) + (T(k + 1,j) - T(k,j)) / (4^j-1);
    end
    n = n * 2;
    d = abs(T(k + 1,k + 1) - T(k,k));
end
I = T(k+1,k+1);