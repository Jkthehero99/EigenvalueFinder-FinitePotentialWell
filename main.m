global inp;
%% Preparing alpha and beta 
disp('Enter a(width of the square well in nanometers), m(mass of the particle in terms of mass of electron), V(finite voltage for the well in eV)');
disp('Example input for a=0.3nm,m = mass of electron, V = 10eV "[0.3,1,10]"');
inp = input('Enter values: ');
p=input('Enter number of decimals needed: ');
%% Random Number Generator between 0(a) and V(b)
rng(0,'twister');
a = 0;
b = inp(3);
r = ((b*0.80) -a).*rand(b*5,1) + a;
%% Secant Output collector
z = -5;
flg =0;
for i=1:size(r,1)
    temp=round(secant(r(i,1),10^-p,-1),p);
    for j=1:size(z,2)
        if temp == z(1,j)
            flg = flg + 1;
        end
    end
    if flg ~= 1
%         z = [z,temp];
        if z(1,1)== -5
            z = temp;
        else
            z = [z,temp];
        end
    elseif flg == 1
        flg = 0;
    end
end
disp('Eigenvalues are: ');
disp(z);
%% Formating data points 
z = sort(z);
d=zeros(size(z,2),2)+1;
for i=1:size(d,1)
    d(i,1)=i;
    d(i,2)=z(1,i);
end
%% Polynomial Fitting 
temp = 0;
%d=input('Enter Data Points');
N=size(d,1);
n=input('Enter degree of polynomial: ');
%% Preparing Matrix A
A=zeros(n+1,n+2)+1;
sumX = zeros(1,2*n)+1;
sumY = zeros(1,n+1)+1;
%% Calculating Sigman(X^i)
for i=1:2*n
    for j=1:N
        temp = temp + d(j,1)^i;
    end
    sumX(1,i) = temp;
    temp = 0;
end
%% Calculating Sigman(X^i)*Y
for i=1:n+1
    for j=1:N
        temp = temp + (d(j,1)^(i-1))*d(j,2);
    end
    sumY(1,i) = temp;
    temp = 0;
end
%% Populating matrix A except n+2th column
for i=1:n+1
    for j=1:n+1
        if i == 1 && j == 1
            A(i,j) = N;
        else
            A(i,j)=sumX(1,i+j-2);
        end
    end
end
%% Populating n+2th column in A 
for i=1:n+1
    A(i,n+2)=sumY(1,i);
end

%% Guassian Elimination 
co=guass(A);
disp('Cofficients in the order of Co,C1,C2 are: ');
disp(co);
cof = flip(co);
%% Graph 
x1=zeros(1,size(d,1));
for i=1:size(d,1)
    x1(1,i)=i;
end
y1=polyval(cof,x1);
plot(x1,y1,'r');
hold on 
for i=1:size(x1,2)
    plot(x1(1,i),z(1,i),'ob');
    hold on
end