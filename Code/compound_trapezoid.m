function Tn = compound_trapezoid(f, x, a, b, n)
% compound trapezoidal formula 
  
    h = (b - a) ./ n;
    k = 0 : n-1;
    xk = a + k .* h;
    % Tn = h/2 * (subs(f, x, a) + subs(f, x, b)) + h .* sum(round(subs(f, x, xk)*100)/100);
    Tn = h/2 * (subs(f, x, a) + subs(f, x, b)) + h .* sum(subs(f, x, xk));
end