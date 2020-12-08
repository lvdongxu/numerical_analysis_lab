f=@(x)(sqrt(x) * log(x));
rel = -4/9;
%y = changed_trapezoid(f, 1e-9, 1, 1e-4);
%y1 = Romberg(f, 1e-9, 1, 1e-4);
%y2 = auto_Simpson(f, 1e-9, 1, 1e-4);
num = 28;
j = 3;
trapezoid_ans = zeros(1, num);
trapezoid_error = zeros(1, num);
Simpson_ans = zeros(1, num);
Simpson_error = zeros(1, num);
numbers = zeros(1, num);
while j <= num
    j = j + 1;
    numbers(j) = 1. / 2^j;
    trapezoid_ans(j) = trapezoid(f, 1e-9, 1, 2^j);
    Simpson_ans(j) = Simpson(f, 1e-9, 1, 2^j);
    trapezoid_error(j) = abs(trapezoid_ans(j) - rel);
    Simpson_error(j) = abs(Simpson_ans(j) - rel);
end
loglog(numbers, trapezoid_error, 'ro-');
hold on;
loglog(numbers, Simpson_error, 'ko-');
xlabel('step numbers');
ylabel('Error');
legend('trapezoid', 'Simpson');
%% test
fun = @(x)(1 / x^2);
y3 = auto_Simpson(fun, 0.2, 1, 0.02);