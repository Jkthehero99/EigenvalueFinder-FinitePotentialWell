function [x1] = secant(x,p,limit)
error = 12;
count = 0;
if limit == -1
    limit = 1000;
end
while error>p && count<limit
    x1=x-funE(x)*0.00001/(funE(x+0.00001)-funE(x));
    error = abs(x1 - x);
    x=x1;
    count = count + 1;
end
%disp(x1);
end


