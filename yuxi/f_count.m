function [y,count_out]=f_count(x,count_in)
    format long
    y=f(x);
    count_out = count_in+length(x);
end