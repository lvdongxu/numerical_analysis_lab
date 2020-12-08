function y = sasps(f, x, a, b, e)
    h = (b - a) / 2;
    y0 = comsps(f, x, a, b, 1);
    y1 = comsps(f, x, a, a+h, 1);
    y2 = comsps(f, x, a+h, b, 1);
    if (abs(y2 + y1 - y0) > e)
        y1 = sasps(f, x, a, a+h, e/2);
        y2 = sasps(f, x, a+h, b, e/2);
        y = y1 + y2;
    else
        y = y1 + y2 + 1/15 * (y1 + y2 - y0);
    end

end