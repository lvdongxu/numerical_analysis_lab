function [t,h,T,count]=variable_step_length_trapezoidal_formula(a,b,limit)
    format long
    k=0;
    h=b-a;
    count=0;
    x=[a,b];
    [y,count]=f_count(x,count);
    T(1,1)=(b-a)*(sum(y))/2;
    k=k+1;
    n=2^k;
    h=(b-a)/n;
    x_mid=(a+h):2*h:(b-h);
    [y_mid,count]=f_count(x_mid,count);
    T(1,k+1)=T(1,k)/2+h*sum(y_mid);
    k=k+1;
    while(abs(T(1,k)-T(1,k-1))>limit)
        n=2^k;
        h=(b-a)/n;
        %T(1,k+1)=compound_trapezoidal_formula(a,b,h);
        x_mid=(a+h):2*h:(b-h);
        [y_mid,count]=f_count(x_mid,count);
        T(1,k+1)=T(1,k)/2+h*sum(y_mid);
        k=k+1;
    end
    k=k-1;
    t=T(1,k+1);
end