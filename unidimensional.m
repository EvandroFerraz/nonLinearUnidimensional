clear all
metodo = 0;

while(metodo < 1 || metodo > 4)
    clear
    clc
    fprintf('Escolha o metodo de resolucao:\n');
    fprintf('1 - Secao Aurea\n');
    fprintf('2 - Bissecao\n');
    fprintf('3 - Fibonacci\n');
    fprintf('4 - Newton\n');
    metodo = input(' ');
end

clc

syms x;

%função f parametrizada em 1 variável
f(x) = (-1-0.8321*x)^4 + ((1-0.8321*x) - 2*(1+0.5547*x))^2;

if(metodo == 1) %(a1,b1) = (-5,5) e E = 0.001
    k = 1;
    fprintf('---Secao Aurea---\n');
    a(k) = input('Digite o ponto inicial do intervalo: ');
    b(k) = input('Digite o ponto final do intervalo: ');
    eps = input('Digite o valor de tolerancia: ');
    alfa = 0.618; %valor padrão de alfa
    
    lambda(k) = a(k) + (1-alfa) * (b(k)-a(k)); %atribuindo valor de lambda(k)
    teta_lambda(k) = subs(f,lambda(k)); %calculando teta de lambda(k)
    
    mi(k) = a(k) + alfa * (b(k)-a(k)); %atribuindo valor de mi(k)
    teta_mi(k) = subs(f, mi(k)); %calculando teta de mi(k)
    
    %Passo principal
    while(abs(b(k)-a(k)) >= eps) %critério de parada do método
        if(teta_lambda(k) > teta_mi(k)) 
            a(k+1) = lambda(k);
            b(k+1) = b(k);
            lambda(k+1) = mi(k);
            teta_lambda(k+1) = teta_mi(k);
            mi(k+1) = a(k+1) + alfa * (b(k+1)-a(k+1));
            teta_mi(k+1) = subs(f,mi(k+1));
        elseif(teta_lambda(k) < teta_mi(k))  
            a(k+1) = a(k);
            b(k+1) = mi(k);
            mi(k+1) = lambda(k);
            teta_mi(k+1) = teta_lambda(k);
            lambda(k+1) = a(k+1) + (1-alfa) * (b(k+1)-a(k+1));
            teta_lambda(k+1) = subs(f, lambda(k+1));
        end
        k = k+1;
    end
   
    clc
    fprintf(1,'Numero de iteracoes: %i \n', k);
    fprintf(1,'Intervalo Final (a,b) = I(%6.4f,%6.4f) \n',a(k),b(k));
    fprintf(1,'Lambda = %6.4f \n', lambda(k));
    fprintf(1,'Mi = %6.4f \n', mi(k));
    fprintf(1,'Teta(lambda) = %6.4f \n', teta_lambda(k));
    fprintf(1,'Teta(mi) = %6.4f \n', teta_mi(k));
    media = (a(k)+b(k))/2;
    fprintf(1,'Valor da Função: %6.4f \n', subs(f,media));
end

if(metodo == 2) %(a1,b1) = (-5,5) e E = 0.001
    fprintf('---Bissecao---\n');
    a(1) = input('Digite o ponto inicial do intervalo: ');
    b(1) = input('Digite o ponto final do intervalo: ');
    eps = input('Digite o valor de tolerancia: ');
    
    %Dados Iniciais
    n = log(eps/(b(1)-a(1)))/log(1/2); %Define o valor de n
    k = 1;
    stop = 0;
    
    %Passo Principal
    while(stop == 0)
       lambda(k) = 1/2*(b(k)+a(k)); %calculando valor de lambda
       x = lambda(k);
       
       %Calcular derivada de teta(lambda)
       teta_lambda_d1 = diff(f);
       t = eval(teta_lambda_d1);
       
       if(t == 0 || k > n) %condição de parada do método
           stop = 1;
       elseif(t > 0)
          a(k+1) = a(k);               
          b(k+1) = lambda(k);
          k = k+1;
       elseif(t < 0)
          a(k+1) = lambda(k); 
          b(k+1) = b(k);
          k = k+1;
       end
    end
    
    %Resultados
    clc
    fprintf('Número de Iteracoes: %i \n', k);
    fprintf('Valor de lambda %6.4f \n', lambda(k));
    fprintf('Intervalo Final I(a(k),b(k)) = I(%6.4f, %6.4f) \n',a(k),b(k));
    media = (a(k)+b(k))/2; %valor apropriado para lambda final
    fprintf('Valor da Funcao f: %6.4f \n', subs(f,media));
end

if(metodo == 3) %(a1,b1) = (-5,5), E = 0.001 e D = 0.001 
    fprintf('---Fibonacci---\n');
    a(1) = input('Digite o ponto inicial do intervalo: ');
    b(1) = input('Digite o ponto final do intervalo: ');
    eps = input('Digite o valor de tolerância: ');
    D = input('Digite a constante de distinção: ');
    k = 1;
    n = 0;
    stop = 0;
    
    %Passo Inicial
    while(fibonacci(n) < (b(1)-a(1))/eps) %define o tamanho de n
        n = n+1;
    end
    
    lambda(1) = a(1) + fibonacci(n-2)*(b(1)-a(1))/fibonacci(n); %define o valor inicial de lambda
    mi(1) = a(1) + fibonacci(n-1)*(b(1)-a(1))/fibonacci(n); %define o valor inicial de mi
    
    %Passo Principal
    while(stop == 0)
        teta_lambda = subs(f,lambda(k)); %atualiza teta de lambda(k)
        teta_mi = subs(f,mi(k)); %atualiza mi de lambda(k)
    
         if(teta_lambda > teta_mi)
            a(k+1) = lambda(k);
            b(k+1) = b(k);
            lambda(k+1) = mi(k);
            mi(k+1) = a(k+1) + fibonacci(n-k-1)*(b(k+1)-a(k+1))/fibonacci(n-k); %atualiza valor de mi(k+1) utilizando a sequência de fibonacci
         else
            a(k+1) = a(k);
            b(k+1) = mi(k);
            mi(k+1) = lambda(k);
            lambda(k+1) = a(k+1) + fibonacci(n-k-2)*(b(k+1)-a(k+1))/fibonacci(n-k); %atualiza valor de lambda(k+1) utilizando a sequêndia de fibonacci
         end
         if(k == n-2) %critério de parada do método
            lambda(n) = lambda(n-1);
            mi(n) = lambda(n-1)+D;
            teta_lambda = subs(f,lambda(n));
            teta_mi = subs(f,mi(n));
            if(teta_lambda > teta_mi)
                a(n) = lambda(n);
                b(n) = b(n-1);
            else
                a(n) = a(n-1);
                b(n) = lambda(n);
            end
            stop = 1;
         end
         k = k+1;
    end
    
    %Resultados
    clc
    fprintf('Número de Iterações: %i \n', k-1);
    fprintf('Valor de n: %i \n', n);
    fprintf('Valor de Lambda(n) %6.4f \n', lambda(n));
    fprintf('Intervalo Final I(a(n),b(n)) = I(%6.4f,%6.4f) \n', a(n),b(n));
    media = (a(n)+b(n))/2; %valor apropriado para lambda final
    fprintf('Valor da Funcao f: %6.4f \n', subs(f,media)); 
end

if(metodo == 4) %lambda1 = 6 e E = 0.001
    fprintf('---Newton---\n');
    lambda(1) = input('Digite o valor inicial: ');
    eps = input('Digite o intervalo de tolerancia: ');
    k = 1;
    
    while 1
        x = lambda(k);
        teta_lambda_d1 = diff(f); %define a derivada primeira de teta de lambda(k)
        fd1 = eval(teta_lambda_d1); %valida o valor da derivada primeira
        teta_lambda_d2 = diff(f,2); %define a derivada segunda de teta lambda(k)
        fd2 = eval(teta_lambda_d2); %valida o valor da derivada primeira
        lambda(k+1) = lambda(k) - (fd1/fd2); %atualiza o valor de lambda(k+1)
        if(abs(lambda(k+1)-lambda(k)) < eps) %critério de para do método
            break;
        else
            k = k+1;
        end
    end

    clc
    fprintf(1,'Numero de iteracoes: %i \n', k);
    fprintf(1,'Lambda(k+1): %6.4f \n', lambda(k+1));
    fprintf(1,'Valor da função f: %6.4f \n', subs(f,lambda(k+1)));
end



        