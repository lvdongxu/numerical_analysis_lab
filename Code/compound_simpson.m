function Sn = compound_simpson(f, x, a, b, n)
    h = (b - a) ./ n;
    k = 0 : n-1;
    f1 = subs(f, x, a + k*h + 1/2*h);
    f2 = subs(f, x, a + k*h);
    Sn = h/6 .* (subs(f, x, a) + subs(f, x, b) + 4 * sum(round(f1*100)/100) + 2 * sum(round(f2(2:n)*100)/100));
    
end