function [t,count]=compound_simpson_formula(a,b,h)
    format long
    count=0;
    x=a:h:b;
    [y,count]=f_count(x,count);
    if (rem((b-a)/h,1)~=0)
        %fprintf('(b-a)/h is not a integer');
        n=length(y(:))-1;
        x_mid=(a+h/2):h:x(1+n);
        [y_mid,count]=f_count(x_mid,count);
        t=(b-a)/6/n*(2*sum(y)-y(1)-y(1+n)+4*sum(y_mid));
    else
        x_mid=(a+h/2):h:(b-h/2);
        [y_mid,count]=f_count(x_mid,count);
        t=h/6*(2*sum(y)-y(1)-y(1+1/h)+4*sum(y_mid));
    end
end