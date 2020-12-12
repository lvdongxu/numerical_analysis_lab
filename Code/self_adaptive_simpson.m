function [complexity_cur,y] = self_adaptive_simpson(f, x, a, b, e, complexity)
    % h = (b - a) / 2;
    % y0 = compound_simpson(f, x, a, b, 1);
    % y1 = compound_simpson(f, x, a, a+h, 1);
    % y2 = compound_simpson(f, x, a+h, b, 1);
    % if (abs(y2 + y1 - y0) > e)
    %     y1 = self_adaptive_simpson(f, x, a, a+h, e/2);
    %     y2 = self_adaptive_simpson(f, x, a+h, b, e/2);
    %     y = y1 + y2;
    % else
    %     y = y1 + y2 + 1/15 * (y1 + y2 - y0);
    % end
    h = (b - a);
    S = h / 6 * (subs(f, x, a) + subs(f, x, a) + 4 * subs(f, x, (a+b)/2));
    h = h / 2;
    S1 = h / 6 * (subs(f, x, a) + subs(f, x, a+h) + 4 * subs(f, x, a+h/2));
    S2 = h / 6 * (subs(f, x, a+h) + subs(f, x, b) + 4 * subs(f, x, a+h*3/2));
    complexity_cur = complexity + 3;
    if abs(S - S1 - S2) < e
        y = S1 + S2 + (S1 + S2 - S) / 15;
    else 
        [complexity_cur_1, y1] = self_adaptive_simpson(f, x, a, (a+b)/2, e/2, complexity_cur);
        [complexity_cur_2, y2] = self_adaptive_simpson(f, x, (a+b)/2, b, e/2, complexity_cur);
        y = y1 + y2;
        complexity_cur = complexity_cur_1 + complexity_cur_2;
    end
end