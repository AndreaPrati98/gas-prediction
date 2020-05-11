clc
clear

gasDataSet = readtable('gasITAday.xlsx', 'Range', 'A3:C732');
xString = 'giornoAnno';
yString = 'giornoSettimana';
zString = 'dati';
gasDataSet.Properties.VariableNames = {xString, yString, zString};

vectDati = gasDataSet.dati';
vectDati = vectDati(150:200);

limiteDati = 50; % quanti dati studiare per farci su il modello
numGiorni = 7;

dati = vectDati(1:limiteDati);
giorni = 1:limiteDati;

errore = 0;
goal = 20; % sum-squared error goal
spread = 100.0;  % spread constant / larghezza campana
MN = 250; % numero massimo di neuroni
DF = 25; % valore magico


for i=1:limiteDati-numGiorni
    dataWeek = dati(i:i+numGiorni-1); % si salva una settimana
    net = newrb(1:numGiorni, dataWeek, goal, spread, MN, DF); % creazione rete con parametri definiti prima
    prediction = sim(net, numGiorni+1); % valore che predice
    disp(i+numGiorni); % DEBUG
    dato = dati(i+numGiorni); % ottavo dato, quello reale
    if i == 1
        errore = abs(dato - prediction);
    else
        errore = [errore, abs(dato-prediction)];
    end      
end

net = newrb(giorni, dati, goal, spread, MN, DF);
graphRbf = net(giorni);

figure(1)
title('Rappresentazione dati');
plot(giorni,dati, 'x');
hold on
plot(giorni,graphRbf);
hold off
legend('Dati','previsione')
xlabel('Giorni');
ylabel('Valore gas');

figure(2)
title('Rappresentazione errore per ogni settimana');
plot(1:length(errore),errore);
xlabel('settimane');
ylabel('Valore errore');

erroreMedio = mean(errore)