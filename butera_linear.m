clc 
clear all 
close all 

%% qui facciamo grafici 



%% 1 grafico dei dati 



%{
    Iniziamo a fare il caricamento dei dati da tabella excel a matlab così
    da poter poi fare un plot e visualizzare un po' la situazione
%}

gasDataSet = readtable('gasITAday.xlsx', 'Range', 'A3:C732');
xString = 'giornoAnno';
yString = 'giornoSettimana';
zString = 'dati';
gasDataSet.Properties.VariableNames = {xString, yString, zString};

vectGiornoAnno = gasDataSet.giornoAnno;
vectGiornoSettimana = gasDataSet.giornoSettimana;
vectDati = gasDataSet.dati;

% attenzione il grafico in 3d è sbagliato 
figure(1)
plot3(vectGiornoAnno, vectGiornoSettimana, vectDati, 'x')
grid on
title('Dati consumo gas 3D')
xlabel(xString)
ylabel(yString)
zlabel(zString)

figure(2)
plot(vectGiornoAnno, vectDati, 'x')
title("Dati consumo gas rispetto ai giorni dell'anno")
grid on
xlabel(xString)
ylabel(zString)

figure(3)
plot(vectGiornoSettimana, vectDati, 'x')
title('Dati consumo gas rispetto ai giorni della settimana')
grid on
xlabel(yString)
ylabel(zString)











%% grafico rete a percettroni 


settimane = 1:30; 
ordinataOriginale = 1:30;  % valori di init
ordinataStimata = 1:30 
figure(4)
title('Confronti dati e previsioni')
ylabel('Gas consumato nel mercoledì di quella settimana')
xlabel('Numero della settimana casuale')
scatter (settimane,ordinataOriginale,'b','o')
hold on
grid on
scatter (settimane, ordinataStimata, 'r' ,'x')
legend('Dati', 'Previsioni')


residui = 1: 30 ; 
residuiInValoreAssoluto = 1 : 30 ; 


figure(5)
xlabel('Numero della settimana')
ylabel('Gas consumato nel mercoledì di quella settimana')
scatter(settimane, residui, 'b','o');
grid on
hold on
scatter(settimane, residuiInValoreAssoluto, 'r', 'x');
legend('Valore residui', 'Valore residui in modulo');





%% grafico rete a base radiale 





%% istogramma dei possibili valori del merocoledì ( stima a posteriori ) 