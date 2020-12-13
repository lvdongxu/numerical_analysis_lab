function y=f(x)
    format long
    x1=x+(x==0);
    y=sqrt(x1).*log(x1);
    %y=round(y*100)/100;
    %y=(x.^1.5);
end