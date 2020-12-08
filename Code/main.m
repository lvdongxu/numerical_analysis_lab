%% ----- Definition ----- %
syms x;
f      = sqrt(x).*log(x);
result = -4/9                  ;
eps    = 1e-20                 ;

%% ----- Test of Simpson and Trapezoid formula ----- %
num                    = 15           ;
n_arr                  = 2 .^ (0:num-1) ;
h_arr                  = 1 ./ n_arr   ;
compound_simpson_res   = zeros(1, num);
compound_simpson_err   = zeros(1, num);
compound_trapezoid_res = zeros(1, num);
compound_trapezoid_err = zeros(1, num);

for i = 1 : num
    n                         = n_arr(i)                               ;
    % ----- compound simpson results ----- %
    compound_simpson_res(i)   = compound_simpson(f, x, eps, 1, n)      ;
    compound_simpson_err(i)   = abs(result - compound_simpson_res(i))  ;
    % ----- compound trapezoid results ----- %
    compound_trapezoid_res(i) = compound_trapezoid(f, x, eps, 1, n)    ;
    compound_trapezoid_err(i) = abs(result - compound_trapezoid_res(i));
end
figure;
loglog(h_arr, compound_trapezoid_err, 'ro-');
hold on
loglog(h_arr, compound_simpson_err, 'ko-')  ;
axis on;
grid on;
axis tight;
set(gca,'XDir','reverse');
xlabel('h: Step size');
ylabel('Error');
legend( ...
        'Compound Trapezoid', ...
        'Compound Simpson', ...
        'Times New Roman', ...
        'Southwest' ...
);

%% ----- Step-changing Trapezoid ----- %
[step_changing_trapezoid_T, step_changing_trapezoid_step] = step_changing_trapezoid(f, x, eps, 1, 1e-4);
step_num_step_changing_trapezoid = 1 ./ step_changing_trapezoid_step;

%% ----- Romberg ----- %
[T_ii, T] = Romberg(f, x, eps, 1, 1e-4, result);
iter                           = size(T, 1);
compound_trapezoid_res_Romberg = T(:,1)    ;
Romberg_res                    = diag(T)   ;
Trapezoid_err                  = abs(result .* ones(iter, 1) - compound_trapezoid_res_Romberg);
Romberg_err                    = abs(result .* ones(iter, 1) - Romberg_res);

figure;
x_label = 1:iter;
loglog(x_label, Trapezoid_err, 'ro-');
hold on
loglog(x_label, Romberg_err, 'ko-')  ;
axis on;
grid on;
axis tight;
% set(gca,'XDir','reverse');
xlabel('h: Step size');
ylabel('Error');
legend( ...
        'T_0^{(k)} Error', ...
        'T_k^{(k)} Error'...
);

%% ----- Self-adaptive Simpson ----- %
y = self_adaptive_simpson(f, x, eps, 1, 1e-4);





