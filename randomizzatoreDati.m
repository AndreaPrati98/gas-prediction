clc
clear

gasDataSet = readtable('gasITAday.xlsx', 'Range', 'A3:C732');
xString = 'giornoAnno';
yString = 'giornoSettimana';
zString = 'dati';
gasDataSet.Properties.VariableNames = {xString, yString, zString};

vectDati = gasDataSet.dati';
%Normalizzo i dati e mi salvo media e deviazione per il processo inverso
media = mean(vectDati);
deviazione = std(vectDati);
vectDati = normalize(vectDati);
weeks = 104;

for i=1:weeks
    if i == 1
        output = vectDati(8);
        input = vectDati(1:7);
    else
        output = [output; vectDati((i*7)+1)];
        input = [input; vectDati(((i-1)*7+1):(i*7))];
    end
end

oldOutput = output;
oldInput = input;

cicli = 1000; %Scambio delle righe 1000 volte

for i=1:cicli
    %scelgo le righe da scambiare casualmente
    prima = randi([1,104],1,1);
    seconda = randi([1,14],1,1);
    
    tmpInput = input(prima,:);
    tmpOutput = output(prima, 1);
    
    input(prima, :) = input(seconda, :);
    output(prima, 1) = output(seconda, 1);
    
    input(seconda, :) = tmpInput;
    output(seconda, 1) = tmpOutput;
end

%Suppongo 30 settimane di validazione
settimaneValidazione = 30;
inputIdentificazione = input(1:104-settimaneValidazione, 1:7);
outputIdentificazione = output(1:104-settimaneValidazione, 1);

inputValidazione = input(104-settimaneValidazione+1:end, 1:7);
outputValidazione = output(104-settimaneValidazione+1:end, 1);

save inputIdentificazione;
save outputIdentificazione;
save inputValidazione;
save outputValidazione;
save media;
save deviazione;