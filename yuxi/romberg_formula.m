function [t,T,k,r,count]=romberg_formula(a,b,limit)
    format long
    r=limit+1;
    k=0;
    count=0;
    while(r>=limit)
        n=2^k;
        h=(b-a)/n;
        %T(1,k+1)=compound_trapezoidal_formula(a,b,h);
        if(k>0)
            x_mid=(a+h):2*h:(b-h);
            [y_mid,count]=f_count(x_mid,count);
            T(1,k+1)=T(1,k)/2+h*sum(y_mid);
        else
            x=[a,b];
            [y,count]=f_count(x,count);
            T(1,1)=(b-a)*(sum(y))/2;
        end
        for i=1:k
            T(i+1,k+1-i)=(4^i*T(i,k+2-i)-T(i,k+1-i))/(4^i-1);
        end
        if(k>0)
            r=abs(T(k+1,1)-T(k,1));
        end
        k=k+1;
    end
    k=k-1;
    t=T(k+1,1);
end