% Datos
Ta = 20.5;
T = importdata('Temperaturas_cilindro_1_cada_segundo.txt');
T = T.data/10;
t = (0:1:(size(T) - 1))';


% Ajuste por mínimos cuadrados
A = zeros(size(T,1),2);
A(:,1)= t;
A(:,2)= ones(size(T,1),1);
AJ = pinv(A)*log(T-Ta);

x=t;
y=log(T-Ta);
N=size(T,1);
sigma2 = sum( (y-x.*AJ(1)-AJ(2)).^2 )/(N-2);
delta  = (N)*sum((x).^2)-sum(x)^2;
e_a=sqrt(N*sigma2/delta);
e_b=sqrt(sum(x.^2)*sigma2/delta);


% Graficas y resultados
plot(x,T)
figure
hold on
plot(x,y)
plot(x,x*AJ(1)+AJ(2))

r= (N*sum(x.*y)-sum(x)*sum(y)) / (sqrt((N*sum(x.^2)-(sum(x)^2))*(N*sum(y.^2)-(sum(y)^2))))
disp("a=")
disp(AJ(1))
disp("+-")
disp(e_a)
disp("b=")
disp(AJ(2))
disp("+-")
disp(e_b)
