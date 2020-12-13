function [t,count]=compound_trapezoidal_formula(a,b,h)
    format long
    count=0;
    x=a:h:b;
    [y,count]=f_count(x,count);
    if (rem((b-a)/h,1)~=0)
        %fprintf('(b-a)/h is not a integer');
        n=length(y(:))-1;
        t=(b-a)/2/n*(2*sum(y)-y(1)-y(1+n));
    else
        t=h/2*(2*sum(y)-y(1)-y(1+1/h));
    end
end