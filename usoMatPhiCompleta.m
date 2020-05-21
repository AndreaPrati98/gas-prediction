clc 
clear
close all 

load gasDataSet.mat;
load matPhiLinearDatiIdentificazioneTotali.mat;
load vettoreMercolediTarget.mat;

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
%% viene eseguito solo per gradi desiderati >=2

phi_bloccoDaDuePrimo = ones(numeroSettimaneDellaPhi,1); % giusto per ricordarmi che sono tot settimane
vect = 0;
k = 1;
for i= 1 : numeroVariabili
    for j= i+1 : numeroVariabili
        for z= 2: gradoDesiderato 
            if(mod(z, 2) == 0)
                vect = (phi_linear(:, i+1).^(z/2)).* phi_linear(:, j+1).^(z/2); 
                phi_bloccoDaDuePrimo(:, k) = vect;
                k = k+1;
            end
        end
    end
end

%% qui si costruiscono i blocchi da due spuri
%% viene eseguito solo se gradoDesiderato >= 3

phi_bloccoDaDueSecondo = ones(numeroSettimaneDellaPhi, 1);
c = 1;
for a= 1 : numeroVariabili
    for b= 1 : numeroVariabili
        if(a ~= b)
           for k= 1 : gradoDesiderato % da controllare con un if
                for j= k+1 : gradoDesiderato
                    disp(j)
                    if(k+j <= gradoDesiderato)
                        vect = (phi_linear(:, a).^j).* phi_linear(:, b).^ k;
                        phi_bloccoDaDueSecondo(:, c) = vect;
                        c = c + 1;
                    end
                end
           end
        end
    end
end

phi_bloccoDaDue = [phi_bloccoDaDuePrimo, phi_bloccoDaDueSecondo];

%% qui si costruiscono i blocchi da 3

%% si esegue solo se gradoDesiderato >=3 

phi_bloccoDaTrePrimo = ones(numeroSettimaneDellaPhi,1); % giusto per ricordarmi che sono tot settimane
vect = 0;
k = 1;
contatoreCaso = 0;
disp('divisione')
for a= 1 : numeroVariabili
    for b= a+1 : numeroVariabili
        for c= b+1 : numeroVariabili
           
            for z= 3: gradoDesiderato 
                if(mod(z, 3) == 0)
                    vect = (phi_linear(:, a+1).^(z/3)).* (phi_linear(:, b+1).^(z/3)).* phi_linear(:, c+1).^(z/3); 
                    phi_bloccoDaTrePrimo(:, k) = vect;
                    k = k+1;
                end
            end
        end
    end
end


%% grado uno

phi_linear_notNormalized_1 = [phi_linear]; 
phi_linear_notNormalized_2 = [phi_linear, phi_blocchiDaUno, phi_bloccoDaDuePrimo];
phi_linear_notNormalized_3 = [phi_linear, phi_blocchiDaUno, phi_bloccoDaDue, phi_bloccoDaTrePrimo];
%{
phi_linear_normalized_1 = normalize(phi_linear_notNormalized_1(:, 2:8));
phi_linear_normalized_2 = normalize(phi_linear_notNormalized_2(:, 2:50));
phi_linear_normalized_3 = normalize(phi_linear_notNormalized_3(:, 2:127));
%}
phi_linear_normalized_1 = phi_linear_notNormalized_1(:, 2:8);
phi_linear_normalized_2 = phi_linear_notNormalized_2(:, 2:50);
phi_linear_normalized_3 = phi_linear_notNormalized_3(:, 2:127);

%Y_normalized = normalize(Y);
Y_normalized = Y;

phi_id_1 = phi_linear_normalized_1(2:70, :);
phi_id_2 = phi_linear_normalized_2(2:70, :);
phi_id_3 = phi_linear_normalized_3(2:70, :);

phi_val_1 = phi_linear_normalized_1(71:end, :);
phi_val_2 = phi_linear_normalized_2(71:end, :);
phi_val_3 = phi_linear_normalized_3(71:end, :);

Y_id = Y_normalized(2:70);
Y_val = Y_normalized(71:104);
[theta_1, std_1] = lscov(phi_id_1, Y_id);
[theta_2, std_2] = lscov(phi_id_2, Y_id);
[theta_3, std_3] = lscov(phi_id_3, Y_id);


ordinataStimata = phi_val_1 * theta_1;
figure(1)
%Non mi vanno le label xlabel('Numero della settimana')
%ylabel('Gas consumato nel mercoledì di quella settimana')
scatter (1:34, Y_val,'r','x')
hold on
grid on
scatter (1:34, ordinataStimata, 'b')
legend('Dati', 'Previsioni')

%Ora calcolo il vettore dei residui e lo plotto per ogni settimana
%(attenzione che il vettore stimato Ã¨ una riga e non una colonna)
residui = Y_val - ordinataStimata;
residuiInValoreAssoluto = abs(residui);

%Calcolo anche SSR
residuiAlQuadrato = residui.^2;
SSR_1 = sum(residuiAlQuadrato);
%Calcolo massimo e minimo residuo in valore assoluto
maxResiduoAbs = max(residuiInValoreAssoluto);
minResiduoAbs = min(residuiInValoreAssoluto);


figure(2)
xlabel('Numero della settimana')
ylabel('Gas consumato nel mercoledì di quella settimana')
scatter(1:34, residui, 'g','o');
grid on
hold on
scatter(1:34, residuiInValoreAssoluto, 'r', 'x');
legend('Valore residui', 'Valore residui in modulo');

phi_id_1 = phi_linear_normalized_1(1:70, :);
ordinataStimata = phi_val_1 * theta_1;
Y_id = Y_normalized(1:70);
[theta_1, std_1] = lscov(phi_id_1, Y_id);

residui = Y_val - ordinataStimata;
residuiInValoreAssoluto = abs(residui);
%Calcolo anche SSR
residuiAlQuadrato = residui.^2;
SSR_1_senza_grado_zero = sum(residuiAlQuadrato);
%Calcolo massimo e minimo residuo in valore assoluto
maxResiduoAbs = max(residuiInValoreAssoluto);
minResiduoAbs = min(residuiInValoreAssoluto);
