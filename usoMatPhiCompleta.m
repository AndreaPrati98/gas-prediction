clc 
clear
close all 

load gasDataSet.mat;
load matPhiLinearDatiIdentificazioneTotali.mat;
xString = 'giornoAnno';
yString = 'giornoSettimana';
zString = 'dati';
gasDataSet.Properties.VariableNames = {xString, yString, zString};

vectGiornoAnno = gasDataSet.giornoAnno;
vectGiornoSettimana = gasDataSet.giornoSettimana;
vectDati = gasDataSet.dati;


%%Indici per i for





%% Primo grado

% devo crearmi due vettore, uno per ogni giorno e poi creare la matrice
% settimana
% Ricordarsi che giorno 1 = mercoledi
% essendo che mancano i dati, abbiamo due giorni in piu e non so gestirli
% quindi opterei, banalmente, di buttarli

numeroDati = length(vectDati); 
giorniSettimana = 7;
numDatiUtili = numeroDati - mod(numeroDati, giorniSettimana);
numSettimane = numDatiUtili / giorniSettimana;

primoGiornoUtile = 0;
for i=1 : giorniSettimana
    if (vectGiornoSettimana(i)==4)
       primoGiornoUtile = i;
    end
end

%Primo giorno in cui trovo un mercoledì
estremoBasso = primoGiornoUtile;


for i=(numeroDati-7) : numeroDati
    if (vectGiornoSettimana(i)==3)
       ultimoGiornoUtile = i;
    end
end

estremoAlto = ultimoGiornoUtile;
numeroSettimaneDellaPhi = (estremoAlto - estremoBasso + 1)/7;
numeroGiorniUtiliDeiVettori = estremoAlto - estremoBasso;

vectGiorno1 = ones(numeroSettimaneDellaPhi, 1); 
vectGiorno2 = ones(numeroSettimaneDellaPhi, 1);
vectGiorno3 = ones(numeroSettimaneDellaPhi, 1);
vectGiorno4 = ones(numeroSettimaneDellaPhi, 1);
vectGiorno5 = ones(numeroSettimaneDellaPhi, 1);
vectGiorno6 = ones(numeroSettimaneDellaPhi, 1);
vectGiorno7 = ones(numeroSettimaneDellaPhi, 1);

j = 1; %fara da contatore di settimane, ricordarsi che gli array partono da 1... che schifo di vita
%for i = 1 : numDatiUtili 

% per il for ho scelto questi intervalli perchÃ¨ devo escludere dati "spuri"
% che non saprei come trattare 

for i = estremoBasso : ultimoGiornoUtile
    % devo scandire la matrice giornoSettimana_dato e assegnare in ogni
    % casella il proprio valore
    disp(vectGiornoSettimana(i))
    disp(vectDati(i))
        
    switch vectGiornoSettimana(i)
        case 1
            % vectGiorno1 = [vectGiorno1, vectDati(i)]; questa sarebbe una
            % soluzione ma matlab dice che costa troppo in termini di tempo
            %disp("ciao")
            vectGiorno1(j) = vectDati(i);
        case 2
            vectGiorno2(j) = vectDati(i);
        case 3
            vectGiorno3(j) = vectDati(i);
        case 4
            vectGiorno4(j) = vectDati(i);
        case 5
            vectGiorno5(j) = vectDati(i);
        case 6
            vectGiorno6(j) = vectDati(i);
        case 7
            vectGiorno7(j) = vectDati(i);
       
        otherwise
            disp("C'Ã¨ qualcosa che non va, non riesco a classificare il giorno ", vectGiornoSettimana(i));
    end
    
    if(mod(i - (estremoBasso - 1), giorniSettimana) == 0)
        j = j + 1;
        disp("Settimana numero "+ j)
        disp('\n')
    end    
end

%% Inizio a costruire la phi completa


gradoDesiderato = 3;

%% questo ciclo for costruisce il blocco da 1
numeroVariabili = giorniSettimana; % ovvero 7 variabili

phi_blocchiDaUno = ones(numeroSettimaneDellaPhi, numeroVariabili * gradoDesiderato);

k = 1;
for i= 1 : gradoDesiderato % la i serve a fare le potenze
    for j= 1 : numeroVariabili % mi aiuta a tener conto delle posizioni
        vect = phi_linear(:, j+1); % il +1 esclude il primo vettore di soli uni
        phi_blocchiDaUno(:, k) = vect.^i;
        k = k + 1;
    end
end

%% qui si costruisce il blocco da 2

for i= 1





