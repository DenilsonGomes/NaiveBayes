%Autor: Denilson Gomes Vaz da Silva
%Graduando em Engenharia da Computa��o
%reconhecimento de Padroes

clear %limpa as variaveis
clc %limpa o visor 
close all

% Gerando o dataset
%--- Classe 1 -----
a1 = randn(1000,1); %atributo a
b1 = randn(1000,1); %atributo b

%--- Classe 2 -----
a2 = randn(1000,1) + 7; %atributo a
b2 = randn(1000,1); %atributo b

%--- Classe 3 -----
a3 = randn(1000,1); %atributo a
b3 = randn(1000,1) + 7; %atributo b

%--- Classe 4 -----
a4 = randn(1000,1) + 7; %atributo a
b4 = randn(1000,1) + 7; %atributo b

%garantir mesmo desvio padr�o para todos
%--- Classe 1 -----
a1 = a1/std(a1); %atributo a
b1 = b1/std(b1); %atributo b

%--- Classe 2 -----
a2 = a2/std(a2); %atributo a
b2 = b2/std(b2); %atributo b

%--- Classe 3 -----
a3 = a3/std(a3); %atributo a
b3 = b3/std(b3); %atributo b

%--- Classe 4 -----
a4 = a4/std(a4); %atributo a
b4 = b4/std(b4); %atributo b

%plota os dados
plot(a1,b1,'*r') %classe 1 em vermelho
hold on
plot(a2,b2,'.g') %classe 2 em verde
plot(a3,b3,'ob') %classe 3 em azul
plot(a4,b4,'xk') %classe 4 em preto

%exibe a tabela de correla��o
corrcoef([a1 a2 a3 b1 b2 b3]);
cov([a1 a2 a3 b1 b2 b3]);

%Gerando os testes s� pra teste mesmo
%Naive Bayes
% sm1 = [mean(a1) mean(b1)];
% sm2 = [mean(a2) mean(b2)];
% sm3 = [mean(a3) mean(b3)];
% sm4 = [mean(a4) mean(b4)];

%--- Classe 1 -----
% teste1 = [randn(10,1) randn(10,1)]; %atributo a e atributo b
% 
% %--- Classe 2 -----
% teste2 = [randn(10,1) + 5 randn(10,1)]; %atributo a e atributo b
% 
% %--- Classe 3 -----
% teste3 = [randn(10,1) randn(10,1) + 5]; %atributo a e atributo b
% 
% %--- Classe 3 -----
% teste4 = [randn(10,1) + 5 randn(10,1) + 5]; %atributo a e atributo b
% 
% %testanto com amostras criadas
% acertos1 = 0;
% acertos2 = 0;
% acertos3 = 0;
% acertos4 = 0;
% for i=1:10
%     if norm(teste1(i,:) - sm1) < norm(teste1(i,:) - sm2) && norm(teste1(i,:) - sm1) < norm(teste1(i,:) - sm3) && norm(teste1(i,:) - sm1) < norm(teste1(i,:) - sm4)
%         acertos1 = acertos1 + 1;
%     end
%     if norm(teste2(i,:) - sm2) < norm(teste2(i,:) - sm1) && norm(teste2(i,:) - sm2) < norm(teste2(i,:) - sm3) && norm(teste2(i,:) - sm2) < norm(teste2(i,:) - sm4)
%         acertos2 = acertos2 + 1;
%     end
%     if norm(teste3(i,:) - sm3) < norm(teste3(i,:) - sm1) && norm(teste3(i,:) - sm3) < norm(teste3(i,:) - sm2) && norm(teste3(i,:) - sm3) < norm(teste3(i,:) - sm4)
%         acertos3 = acertos3 + 1;
%     end
%     if norm(teste4(i,:) - sm4) < norm(teste4(i,:) - sm1) && norm(teste4(i,:) - sm4) < norm(teste4(i,:) - sm2) && norm(teste4(i,:) - sm4) < norm(teste4(i,:) - sm3)
%         acertos4 = acertos4 + 1;
%     end
% end

acertos1Total = 0;
acertos2Total = 0;
acertos3Total = 0;
acertos4Total = 0;
%---- 10-Fold ----
for f=1:10
    %amostras de teste
    teste1 = [a1(1 + (f-1)*100 : f*100) b1(1 + (f-1)*100 : f*100)];
    teste2 = [a2(1 + (f-1)*100 : f*100) b2(1 + (f-1)*100 : f*100)];
    teste3 = [a3(1 + (f-1)*100 : f*100) b3(1 + (f-1)*100 : f*100)];
    teste4 = [a4(1 + (f-1)*100 : f*100) b4(1 + (f-1)*100 : f*100)];
    
    %amostras de treino
    treino1 = [a1 b1];
    treino1(1 + (f-1)*100 : f*100, :) = [];
    treino2 = [a2 b2];
    treino2(1 + (f-1)*100 : f*100, :) = [];
    treino3 = [a3 b3];
    treino3(1 + (f-1)*100 : f*100, :) = [];
    treino4 = [a4 b4];
    treino4(1 + (f-1)*100 : f*100, :) = [];
    
    %--- Naive Bayes ---
    %zerando os acertos
    acertos1 = 0;
    acertos2 = 0;
    acertos3 = 0;
    acertos4 = 0;
    
    % Calculando vetor medio de cada classes
    sm1 = [mean(a1) mean(b1)];
    sm2 = [mean(a2) mean(b2)];
    sm3 = [mean(a3) mean(b3)];
    sm4 = [mean(a4) mean(b4)];
    
    for i=1:length(teste1)
        if norm(teste1(i,:) - sm1) < norm(teste1(i,:) - sm2) && norm(teste1(i,:) - sm1) < norm(teste1(i,:) - sm3) && norm(teste1(i,:) - sm1) < norm(teste1(i,:) - sm4)
            acertos1 = acertos1 + 1;
        end
        if norm(teste2(i,:) - sm2) < norm(teste2(i,:) - sm1) && norm(teste2(i,:) - sm2) < norm(teste2(i,:) - sm3) && norm(teste2(i,:) - sm2) < norm(teste2(i,:) - sm4)
            acertos2 = acertos2 + 1;
        end
        if norm(teste3(i,:) - sm3) < norm(teste3(i,:) - sm1) && norm(teste3(i,:) - sm3) < norm(teste3(i,:) - sm2) && norm(teste3(i,:) - sm3) < norm(teste3(i,:) - sm4)
            acertos3 = acertos3 + 1;
        end
        if norm(teste4(i,:) - sm4) < norm(teste4(i,:) - sm1) && norm(teste4(i,:) - sm4) < norm(teste4(i,:) - sm2) && norm(teste4(i,:) - sm4) < norm(teste4(i,:) - sm3)
            acertos4 = acertos4 + 1;
        end
    end
    acertos1Total = acertos1Total + acertos1;
    acertos2Total = acertos2Total + acertos2;
    acertos3Total = acertos3Total + acertos3;
    acertos4Total = acertos4Total + acertos4;
end