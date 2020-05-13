clc
clear

gasDataSet = readtable('gasITAday.xlsx', 'Range', 'A3:C732');
xString = 'giornoAnno';
yString = 'giornoSettimana';
zString = 'dati';
gasDataSet.Properties.VariableNames = {xString, yString, zString};

vectDati = gasDataSet.dati';

%Inizio a creare la matrice coi dati

weeks = floor(length(vectDati)/7); %Ricavo il numero di settimane
week = 1:7; %Creo vettore 1,2...7

%ricavo input (tutte le settimane, in matrice) e l'output (l'ottavo giorno)
for i=1:weeks
    if i == 1
        ottavoGiorno = vectDati(8);
        matDati = vectDati(1:7);
    else
        ottavoGiorno = [ottavoGiorno; vectDati((i*7)+1)];
        matDati = [matDati; vectDati(((i-1)*7+1):(i*7))];
    end
end

%trasposte perchè la funzione le vuole così
input = matDati';
output = ottavoGiorno';

goal = 1; % sum-squared error goal
spread = 5;  % spread constant / larghezza campana
MN = 100; % numero massimo di neuroni
DF = 25; % valore magico

net = newrb(input, output, goal, spread, MN);

%Predico il valore per ogni settimana e lo confronto col valore effettivo
for i = 1:weeks
    if i == 1
        prediction = sim(net, input(:, i));
        real = input(1,i+1);
        errore = real-prediction;
    elseif(i < 104)
        prediction = [prediction, sim(net, input(:, i))];
        real = [real, input(1,i+1)];
        errore = [errore, input(1,i+1)-prediction(i)];
    end
end

erroreMedio = mean(abs(errore));
var = var(abs(errore));

figure(1)
subplot(1,2,1);
plot(1:103, real);
hold on
plot(1:103, prediction);
legend('Dati reali','previsione')
titolo = sprintf('Dati');
title(titolo);
xlabel('settimane');
ylabel('Valore errore');

subplot(1,2,2);
plot(1:103, errore);
titolo = sprintf('errore medio=%d, var = %d', erroreMedio, var)
title(titolo);
xlabel('settimane');
ylabel('Valore errore');


%serve solo a vedere come varia l'errore con l'aumento del numero dei
%neuroni
numNeur =[0, 1, 2, 5 10, 20, 50, 100, 200, 500, 1000];

for j = 1:12
    if j<12
        net = newrb(input, output, goal, spread, numNeur(j), DF);
    else
        net = newrb(input, output);
    end

    settimane = 104;
    for i = 1:settimane
        if i == 1
            prediction = sim(net, input(:, i));
            real = input(1,i+1);
            errore = real-prediction;
        elseif(i < 104)
            prediction = [prediction, sim(net, input(:, i))];
            real = [real, input(1,i+1)];
            errore = [errore, input(1,i+1)-prediction(i)];
        end
    end
    erroreMedio(j) = mean(abs(errore));
    
    if j<12
        titolo = sprintf('errMed=%d - NumNeu=%d', erroreMedio(j), numNeur(j));
    else
        titolo = sprintf('errMed=%d - NumNeu=?', erroreMedio(j));
    end
    figure(2)
    display(sprintf('plotto %d', j));
    subplot(3,4,j)
    plot(1:103, errore)
    title(titolo);
    xlabel('settimane');
    ylabel('Valore errore');
end

figure(3);
bar(erroreMedio);
