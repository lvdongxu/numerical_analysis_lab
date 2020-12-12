n = 10000;%Define the maximum number of the steps

h = zeros(n,1);
y_composite_trapezoidal = zeros(n,1);
y_composite_simpson = zeros(n,1);
diff_composite_trapezoidal = zeros(n,1);
diff_composite_simpson = zeros(n,1);
complexity_composite_trapezoidal = zeros(n,1);
complexity_composite_simpson = zeros(n,1);

%Composite trapezoidal formula
for i = 1:n
    h(i) = 1 / i;
    xk = zeros(i-1,1);
    sum = 0;
    complexity_composite_trapezoidal(i) = 0;
    for j = 1:i-1
        xk(j) = eps + j * h(i);
        sum = sum + sqrt(xk(j)) * log(xk(j));
        complexity_composite_trapezoidal(i) = complexity_composite_trapezoidal(i) + 1;
    end
    y_composite_trapezoidal(i) = h(i) / 2 * (sqrt(eps) * log(eps) + sqrt(1) * log(1) + 2 * sum);
    complexity_composite_trapezoidal(i) = complexity_composite_trapezoidal(i) + 2;
    diff_composite_trapezoidal(i) = abs(- 4 / 9 - y_composite_trapezoidal(i));
end

%Composite Simpson formula
for i = 1:n
    xk = zeros(i,1);
    sum_1 = 0;
    sum_2 = 0;
    complexity_composite_simpson(i) = 0;
    for j = 1:i
        xk(j) = eps + (j - 1) * h(i);
        sum_1 = sum_1 + sqrt(xk(j)+h(i)/2) * log(xk(j)+h(i)/2);
        complexity_composite_simpson(i) = complexity_composite_simpson(i) + 1;
    end
    for j = 1:i-1
        sum_2 = sum_2 + sqrt(xk(j+1)) * log(xk(j+1));
        complexity_composite_simpson(i) = complexity_composite_simpson(i) + 1;
    end
    y_composite_simpson(i) = h(i) / 6 * (sqrt(eps) * log(eps) + sqrt(1) * log(1) + 4 * sum_1 + 2 * sum_2);
    complexity_composite_simpson(i) = complexity_composite_simpson(i) + 2;
    diff_composite_simpson(i) = abs(- 4 / 9 - y_composite_simpson(i));
end

%Variable step-length trapezoidal formula
k = 1;
y_variable_trapezoidal = (sqrt(eps) * log(eps) + sqrt(1) * log(1)) / 2;
diff_variable_trapezoidal = abs(y_variable_trapezoidal + 4 / 9);
complexity_variable_trapezoidal = 1;
while(diff_variable_trapezoidal >= 10^-4)
    k = k + 1;
    sum = 0;
    for i = 1:2^(k-2)
        sum = sum + sqrt((2*i-1) / 2^(k-1)) * log((2*i-1) / 2^(k-1));
        complexity_variable_trapezoidal = complexity_variable_trapezoidal + 1;
    end
    y_variable_trapezoidal = y_variable_trapezoidal / 2 + sum / 2^(k-1);
    diff_variable_trapezoidal = abs(y_variable_trapezoidal + 4 / 9);
end
h_variable_trapezoidal = 1 / 2^(k-1);

%Romberg formula
T = zeros(20,20); %20 is large enough, can guarantee results
k = 1;
T(1,1) = (sqrt(eps) * log(eps) + sqrt(1) * log(1)) / 2;
complexity_romberg = 1;

k = 2;
T(2,1) = T(1,1) / 2 + sqrt(0.5) * log(0.5) / 2;
m = 1;
T(2,2) = 4^m / (4^m - 1) * T(2,1) - T(1,1) / (4^m - 1);
complexity_romberg = complexity_romberg + 1;

diff_romberg = abs(T(2,2) - T(1,1));

while(diff_romberg >= 10^-4)
    k = k + 1;
    for i = 1:2^(k-2)
        T(k,1) = T(k,1) + sqrt((2*i-1)/2^(k-1)) * log((2*i-1)/2^(k-1)) / 2^(k-1);
        complexity_romberg = complexity_romberg + 1;
    end
    T(k,1) = T(k,1) + T(k-1,1) / 2;
    for i = 2:k
        m = i - 1;
        T(k,i) = 4^m / (4^m - 1) * T(k,i-1) - T(k-1,i-1) / (4^m - 1);
    end
    diff_romberg = abs(T(k,k) - T(k-1,k-1));
end
y_romberg = T(k,k);
k_romberg = k - 1;

%Adaptive Simpson formula, realized by function due to its self-iterative nature
[y_adaptive_simpson,complexity_adaptive_simpson] = adaptive_simpson(eps,1,10^-4,0);
diff_adaptive_simpson = abs(y_adaptive_simpson + 4 / 9);

%plot and print
% x = 1:n;
% subplot(1,2,1)
% plot(x,diff_composite_trapezoidal);
% subplot(1,2,2)
loglog(h,diff_composite_trapezoidal);
hold on
loglog(h,diff_composite_simpson);
xlabel('step(h)');
ylabel('error');
legend('Composite trapezoidal','Composite simpson');
%print the result of composite trapezoidal fomula and composite Simpson fomula
fprintf("The result of composite trapezoidal fomula and composite Simpson fomula:\n");
for i = 2:n
    if (diff_composite_trapezoidal(i-1) > 10^-3 && diff_composite_trapezoidal(i) < 10^-3)
        fprintf("If step < %f , composite trapezoidal fomula's error is less than 10e-3, ", 1/i);
        fprintf("computational complexity is %d\n", complexity_composite_trapezoidal(i));
    elseif (diff_composite_trapezoidal(i-1) > 10^-4 && diff_composite_trapezoidal(i) < 10^-4)
        fprintf("If step < %f, composite trapezoidal fomula's error is less than 10e-4, ", 1/i);
        fprintf("computational complexity is %d\n", complexity_composite_trapezoidal(i));
    elseif (diff_composite_trapezoidal(i-1) > 10^-5 && diff_composite_trapezoidal(i) < 10^-5)
        fprintf("If step < %f, composite trapezoidal fomula's error is less than 10e-5, ", 1/i);
        fprintf("computational complexity is %d\n", complexity_composite_trapezoidal(i));
    elseif (diff_composite_trapezoidal(i-1) > 10^-6 && diff_composite_trapezoidal(i) < 10^-6)
        fprintf("If step < %f, composite trapezoidal fomula's error is less than 10e-6, ", 1/i);
        fprintf("computational complexity is %d\n", complexity_composite_trapezoidal(i));
    end
    if (diff_composite_simpson(i-1) > 10^-3 && diff_composite_simpson(i) < 10^-3)
        fprintf("If step < %f , composite Simpson fomula's error is less than 10e-3, ", 1/i);
        fprintf("computational complexity is %d\n", complexity_composite_simpson(i));
    elseif (diff_composite_simpson(i-1) > 10^-4 && diff_composite_simpson(i) < 10^-4)
        fprintf("If step < %f, composite Simpson fomula's error error is less than 10e-4, ", 1/i);
        fprintf("computational complexity is %d\n", complexity_composite_simpson(i));
    elseif (diff_composite_simpson(i-1) > 10^-5 && diff_composite_simpson(i) < 10^-5)
        fprintf("If step < %f, composite Simpson fomula's error error is less than 10e-5, ", 1/i);
        fprintf("computational complexity is %d\n", complexity_composite_simpson(i));
    elseif (diff_composite_simpson(i-1) > 10^-6 && diff_composite_simpson(i) < 10^-6)
        fprintf("If step < %f, composite Simpson fomula's error error is less than 10e-6, ", 1/i);
        fprintf("computational complexity is %d\n", complexity_composite_simpson(i));
    end
    if (i == n)
        fprintf("When step = 0.0001, composite trapezoidal fomula's error is %10.9f, ", diff_composite_trapezoidal(i));
        fprintf("computational complexity is %d\n", complexity_composite_trapezoidal(i));
        fprintf("When step = 0.0001, composite Simpson fomula's error is %10.9f, ", diff_composite_simpson(i));
        fprintf("computational complexity is %d\n", complexity_composite_simpson(i));
    end
end
%print the result of variable-step trapezoidal fomula
fprintf("\nThe result of variable-step trapezoidal fomula:\n");
fprintf("When step h = %f, error is %10.9f, less than 10e-4\n", h_variable_trapezoidal, diff_variable_trapezoidal);
fprintf("At this time, result = %f, and computational complexity is %d\n", y_variable_trapezoidal, complexity_variable_trapezoidal);
%print the result of Romberg fomula
fprintf("\nThe result of Romberg fomula:\n");
fprintf("When k = %d, error is %10.9f, less than 10e-4\n", k_romberg, diff_romberg);
fprintf("At this time, result = %f, and computational complexity is %d\n", y_romberg, complexity_romberg);
%print the result of adaptive Simpson fomula
fprintf("\nThe result of adaptive Simpson fomula:\n");
fprintf("Adaptive Simpson fomula's result = %f, whose error is %10.9f, and computational complexity is %d\n", y_adaptive_simpson, diff_adaptive_simpson, complexity_adaptive_simpson);


