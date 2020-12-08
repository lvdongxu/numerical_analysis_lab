function y = self_adaptive_simpson(f, x, a, b, e)
    h = (b - a) / 2;
    y0 = compound_simpson(f, x, a, b, 1);
    y1 = compound_simpson(f, x, a, a+h, 1);
    y2 = compound_simpson(f, x, a+h, b, 1);
    if (abs(y2 + y1 - y0) > e)
        y1 = self_adaptive_simpson(f, x, a, a+h, e/2);
        y2 = self_adaptive_simpson(f, x, a+h, b, e/2);
        y = y1 + y2;
    else
        y = y1 + y2 + 1/15 * (y1 + y2 - y0);
    end
end