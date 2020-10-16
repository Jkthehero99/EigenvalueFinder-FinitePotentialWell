function [x] = guass(a)
nRows = size(a,1);
nColum = size(a,2);
b = a;
x(1,nRows) = 0;
sum = 0;
disp('Starting');
for i=1:1:nColum
    for j=i+1:1:nRows
        for z=i:1:nColum
            b(j,z) = a(j,z) - a(i,z)*a(j,i)/a(i,i);
        end
    end
    a=b;
end
c = b;
%disp(c)
%%Back substitution
%%x(1,counter) = (a(counter,nColum) - sum)/a(counter,nColum-1:2:3:4);
for i=nRows:-1:1
    x(1,i) = (a(i,nColum) - sum)/a(i,nColum-(nRows+1-i));
    sum = 0;
    if i ~=1 
        for j=1:1:nRows-i+1
            sum = sum + x(1,nColum-j)*a(i-1,nColum-j);
        end
    end
end
%disp(x);
end


