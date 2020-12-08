function Sn = comsps(f, x, a, b, n)
    h = (b - a) ./ n;
    k = 0 : n-1;
    f1 = subs(f, x, a + k*h + 1/2*h);
    f2 = subs(f, x, a + k*h);
    Sn = h/6 .* (subs(f, x, a) + subs(f, x, b) + 4 * sum(f1) + 2 * sum(f2(2:n)));
    
end