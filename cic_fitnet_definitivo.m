%Cic definitivo
clc
clear
close all

load inputIdentificazione;
load outputIdentificazione;
load inputValidazione;
load outputValidazione;
load media;
load deviazione;

%Ricordarsi che bisogna fare la trasposta
x = [inputIdentificazione; inputValidazione]';
t = [outputIdentificazione; outputValidazione]';


trainFcn = 'trainlm';  % Levenberg-Marquardt backpropagation.
hiddenLayerSize = 6;
disp("Numero layer nascosti="+hiddenLayerSize);
net = fitnet(hiddenLayerSize,trainFcn);

%Non posso mettere a zero test e validazione
%Quindi uso i dati di identificazione per tutto
%Sapendo che in realtà la rete sarà truccata
[trainInd,valInd,testInd] = divideind(...
                            1:104,...
                            1:74,...
                            75:104,...%indicePartenzaValidazione
                            1:1);

net.dividefcn = 'divideind';
net.divideParam.trainInd = trainInd;
net.divideParam.valInd = valInd;
net.divideParam.testInd = testInd;

[net,tr] = train(net,x,t);

%Calcolo sull'identificazione
xIdentificazione = inputIdentificazione';
y = net(xIdentificazione);
e = gsubtract(outputIdentificazione,y);
performanceIdentificazione = perform(net,outputIdentificazione,y);
disp("Performance di identificazione="+performanceIdentificazione);



%%Ora proviamo la validazione
xValidazione = inputValidazione';
y = net(xValidazione);
e = gsubtract(outputValidazione,y);
performanceValidazione = perform(net,outputValidazione,y);
disp("Performance di validazione="+performanceValidazione);

ordinataOriginale = outputValidazione;
ordinataStimata = y';
residui = ordinataOriginale - ordinataStimata;
residuiInValoreAssoluto = abs(residui);

%Calcolo anche SSR
residuiAlQuadrato = residui.^2;
SSRValidazione = sum(residuiAlQuadrato);
disp("SSR VALIDAZIONE="+SSRValidazione);

%Faccio lo scatter con i dati della validazione
settimane = 1:length(ordinataOriginale);


figure(1)
title('Confronti dati e previsioni')
ylabel('Gas consumato nel mercoledì di quella settimana')
xlabel('Numero della settimana casuale')
scatter (settimane,ordinataOriginale,'r','x')
hold on
grid on
scatter (settimane, ordinataStimata, 'b')
legend('Dati', 'Previsioni')

figure(2)
xlabel('Numero della settimana')
ylabel('Gas consumato nel mercoledì di quella settimana')
scatter(settimane, residui, 'g','o');
grid on
hold on
scatter(settimane, residuiInValoreAssoluto, 'r', 'x');
legend('Valore residui', 'Valore residui in modulo');
