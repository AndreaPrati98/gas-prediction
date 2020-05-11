clc 
close all
clear

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

%% Primo grado

% devo crearmi due vettore, uno per ogni giorno e poi creare la matrice
% settimana
% Ricordarsi che giorno 1 = mercoledi
% essendo che mancano i dati, abbiamo due giorni in piu e non so gestirli
% quindi opterei, banalmente, di buttarli

n = length(vectDati);
giorniSettimana = 7;
numDatiUtili = n - mod(n, giorniSettimana);
numSettimane = numDatiUtili / giorniSettimana;

vectGiorno1 = ones(103, 1); 
vectGiorno2 = ones(103, 1);
vectGiorno3 = ones(103, 1);
vectGiorno4 = ones(103, 1);
vectGiorno5 = ones(103, 1);
vectGiorno6 = ones(103, 1);
vectGiorno7 = ones(103, 1);

j = 1; %fara da contatore di settimane, ricordarsi che gli array partono da 1... che schifo di vita
%for i = 1 : numDatiUtili 

% per il for ho scelto questi intervalli perchè devo escludere dati "spuri"
% che non saprei come trattare 
for i = 6 : 726 
    % devo scandire la matrice giornoSettimana_dato e assegnare in ogni
    % casella il proprio valore
    disp(vectGiornoSettimana(i))
    disp(vectDati(i))
        
    switch vectGiornoSettimana(i)
        case 1
            % vectGiorno1 = [vectGiorno1, vectDati(i)]; questa sarebbe una
            % soluzione ma matlab dice che costa troppo in termini di tempo
            disp("ciao")
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
            disp("C'è qualcosa che non va, non riesco a classificare il giorno ", vectGiornoSettimana(i));
    end
    
    if(mod(i-5, giorniSettimana) == 0)
        j = j + 1;
        disp("Settimana numero "+ j)
        disp('\n')
    end    
end

Y = [vectGiorno4(2:end); vectDati(730)];

% ricordarsi che abbiamo buttato via gli ultimi quattro giorni e i primi cinque

%% 

phi_0 = ones(103, 1); 
[theta_0, stdTheta_0] = lscov(phi_0, Y);





