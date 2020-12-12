function [y_adaptive_simpson,complexity_adaptive_simpson] = adaptive_simpson(a,b,e,pre_complexity)
    h = (b - a) / 2;
    y0 = (sqrt(a) * log(a) + sqrt((a+b)/2) * log((a+b)/2) * 4 + sqrt(b) * log(b)) * (b - a) / 6;
    y1 = (sqrt(a) * log(a) + sqrt(a+h/2) * log(a+h/2) * 4 + sqrt(a+h) * log(a+h)) * (b - a) / 12;
    y2 = (sqrt(a+h) * log(a+h) + sqrt(a+3*h/2) * log(a+3*h/2) * 4 + sqrt(b) * log(b)) * (b - a) / 12;
    complexity_adaptive_simpson = pre_complexity + 3;
    if (abs(y1+y2-y0) > e)
        [y1,complexity_adaptive_simpson] = adaptive_simpson(a,a+h,e/2,complexity_adaptive_simpson);
        [y2,complexity_adaptive_simpson] = adaptive_simpson(a+h,b,e/2,complexity_adaptive_simpson);
        y_adaptive_simpson = y1 + y2;
    else
        y_adaptive_simpson = y1 + y2 + (y1 + y2 - y0) / 15;
    end
end