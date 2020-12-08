f = @(x)sqrt(x).*log(x);
res = -4/9;
%%
%tic toc
num = 28;
h_arr = 1./2.^(0:1:num);
Compound_Trapezoid = zeros(1, num + 1);
Compound_Trapezoid_Error = zeros(1, num + 1);

Compound_Simpson = zeros(1, num + 1);
Compound_Simpson_Error = zeros(1, num + 1);

for i = 1:1:num + 1
    h = h_arr(i);
    x = 0:h:1;
    % Compound Trapezoid
    Compound_Trapezoid(i) = h/2*(f(1e-9) + 2 * sum(f(x(2:end - 1))) + f(x(end)));
    Compound_Trapezoid_Error(i) = abs(Compound_Trapezoid(i) - res);
    
    % Compound Simpson
    Compound_Simpson(i) = h/6*(f(1e-9) + 2 * sum(f(x(2:end - 1))) + f(x(end)));
    x = x + h/2;
    Compound_Simpson(i) = Compound_Simpson(i) + 4*h/6*sum(f(x(1:end-1)));
    Compound_Simpson_Error(i) = abs(Compound_Simpson(i) - res);
end

loglog(h_arr, Compound_Trapezoid_Error, 'ro-');
hold on
loglog(h_arr, Compound_Simpson_Error, 'ko-');
axis on; grid on;axis tight;set(gca,'XDir','reverse');
xlabel('step size');ylabel('Error');
legend('Compound Trapezoid','Compound Simpson');

%% Step changed Trapezoid
step = 1;
h = 1;
int_Trapezoid = (f(1e-9) + f(1)) * h / 2;
last_int_Trapezoid = 0;
while abs(int_Trapezoid - last_int_Trapezoid) >= 1e-4
    last_int_Trapezoid = int_Trapezoid;
    x = 0:h:1;
    h = h/2;
    x = x + h;
    int_Trapezoid = int_Trapezoid*0.5 + h * sum(f(x(1:end-1)));
    step = step + 1;
end
step
error = abs(int_Trapezoid - res)

%% Romberg
step = 1;
h = 1;
Romberg_Mat = (f(1e-9) + f(1)) * h / 2;
while  abs(Romberg_Mat(end, end) - res) >= 1e-4
    Romberg_Mat = [Romberg_Mat zeros(size(Romberg_Mat,1),1); zeros(1, size(Romberg_Mat,1)+1)];
    x = 0:h:1; h = h/2; x = x + h;
    Romberg_Mat(end, 1) = Romberg_Mat(end - 1, 1)*0.5 + h * sum(f(x(1:end - 1)));
    for j = 2:1:size(Romberg_Mat,1)
        Romberg_Mat(end,j) = 4^(j-1)/(4^(j-1) - 1)*Romberg_Mat(end, j - 1) - Romberg_Mat(end - 1, j - 1)/(4^(j-1) - 1);
    end
end
Romberg_Mat

%% Step change Simpson
h = 1;
x_min = 1e-9; x_max = 1;
thr = 1e-4;
x = 0:1;
auto_Simpson(x_min, x_max, f, h, x, thr) 

%%
f = @(x) 1./x./x;
h = 0.8;
x_min = 0.2; x_max = 1;
thr = 0.02;
x = [0.2 1];
auto_Simpson(x_min, x_max, f, h, x, thr) 