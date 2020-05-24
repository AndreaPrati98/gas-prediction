clc 
clear
close all 

load outputIdentificazione.mat
load deviazione.mat
load media.mat
load inputIdentificazione.mat

load outputValidazione.mat
load inputValidazione.mat
%%
[row_identificazione, column_identificazione] = size(inputIdentificazione);
[row_validazione, column_validazione] = size(outputValidazione);

numeroSettimaneDellaPhi = row_identificazione;
numeroVariabili = 7; % ovvero 7 giorni

%% blocco da 1
gradoDesiderato = 2;
phi_blocchiDaUno_2grado = ones(numeroSettimaneDellaPhi, numeroVariabili * gradoDesiderato);
phi_linear = [ones(row_identificazione, 1), inputIdentificazione];

k = 1;
for i= 1 : gradoDesiderato % la i serve a fare le potenze
    for j= 1 : numeroVariabili % mi aiuta a tener conto delle posizioni
        vect = phi_linear(:, j+1); % il +1 esclude il primo vettore di soli uni
        phi_blocchiDaUno_2grado(:, k) = vect.^i;
        k = k + 1;
    end
end

%% blocco da 2 pari

phi_bloccoDaDuePrimo_2grado = ones(numeroSettimaneDellaPhi,1); % giusto per ricordarmi che sono tot settimane
vect = 0;
k = 1;
for i= 1 : numeroVariabili
    for j= i+1 : numeroVariabili
        for z= 2: gradoDesiderato 
            if(mod(z, 2) == 0)
                vect = (phi_linear(:, i+1).^(z/2)).* phi_linear(:, j+1).^(z/2); 
                phi_bloccoDaDuePrimo_2grado(:, k) = vect;
                k = k+1;
            end
        end
    end
end

%% blocco da 1 
gradoDesiderato = 3;

phi_blocchiDaUno_3grado = ones(numeroSettimaneDellaPhi, numeroVariabili * gradoDesiderato);

numeroVariabili = 7; % ovvero 7 variabili

k = 1;
for i= 1 : gradoDesiderato % la i serve a fare le potenze
    for j= 1 : numeroVariabili % mi aiuta a tener conto delle posizioni
        vect = phi_linear(:, j+1); % il +1 esclude il primo vettore di soli uni
        phi_blocchiDaUno_3grado(:, k) = vect.^i;
        k = k + 1;
    end
end

%% blocco da 2 pari

phi_bloccoDaDuePrimo_3grado = ones(numeroSettimaneDellaPhi,1); % giusto per ricordarmi che sono tot settimane
vect = 0;
k = 1;
for i= 1 : numeroVariabili
    for j= i+1 : numeroVariabili
        for z= 2: gradoDesiderato 
            if(mod(z, 2) == 0)
                vect = (phi_linear(:, i+1).^(z/2)).* phi_linear(:, j+1).^(z/2); 
                phi_bloccoDaDuePrimo_3grado(:, k) = vect;
                k = k+1;
            end
        end
    end
end

%% blocco da 2 dispari

phi_bloccoDaDueSecondo_3grado = ones(numeroSettimaneDellaPhi, 1);
c = 1;
for a= 1 : numeroVariabili
    for b= 1 : numeroVariabili
        if(a ~= b)
           for k= 1 : gradoDesiderato % da controllare con un if
                for j= k+1 : gradoDesiderato
                    %disp(j)
                    if(k+j <= gradoDesiderato)
                        vect = (phi_linear(:, a).^j).* phi_linear(:, b).^ k;
                        phi_bloccoDaDueSecondo_3grado(:, c) = vect;
                        c = c + 1;
                    end
                end
           end
        end
    end
end

phi_bloccoDaDue_3grado = [phi_bloccoDaDuePrimo_3grado, phi_bloccoDaDueSecondo_3grado];

%% blocco da 3

phi_bloccoDaTrePrimo_3grado = ones(numeroSettimaneDellaPhi,1); % giusto per ricordarmi che sono tot settimane
vect = 0;
k = 1;
for a= 1 : numeroVariabili
    for b= a+1 : numeroVariabili
        for c= b+1 : numeroVariabili
           
            for z= 3: gradoDesiderato 
                if(mod(z, 3) == 0)
                    vect = (phi_linear(:, a+1).^(z/3)).* (phi_linear(:, b+1).^(z/3)).* phi_linear(:, c+1).^(z/3); 
                    phi_bloccoDaTrePrimo_3grado(:, k) = vect;
                    k = k+1;
                end
            end
            
        end
    end
end

%% blocco da 1 validazione
gradoDesiderato = 2;
phi_blocchiDaUno_2grado_val = ones(row_validazione, numeroVariabili * gradoDesiderato);

numeroVariabili = 7; % ovvero 7 variabili
phi_linear = [ones(row_validazione, 1), inputValidazione];

k = 1;
for i= 1 : gradoDesiderato % la i serve a fare le potenze
    for j= 1 : numeroVariabili % mi aiuta a tener conto delle posizioni
        vect = phi_linear(:, j+1); % il +1 esclude il primo vettore di soli uni
        phi_blocchiDaUno_2grado_val(:, k) = vect.^i;
        k = k + 1;
    end
end

%% blocco da 2 pari validazione

phi_bloccoDaDuePrimo_2grado_val = ones(row_validazione,1); % giusto per ricordarmi che sono tot settimane
vect = 0;
k = 1;
for i= 1 : numeroVariabili
    for j= i+1 : numeroVariabili
        for z= 2: gradoDesiderato 
            if(mod(z, 2) == 0)
                vect = (phi_linear(:, i+1).^(z/2)).* phi_linear(:, j+1).^(z/2); 
                phi_bloccoDaDuePrimo_2grado_val(:, k) = vect;
                k = k+1;
            end
        end
    end
end

%% blocco da 1 validazione
gradoDesiderato = 3;

numeroVariabili = 7; % ovvero 7 variabili
phi_linear = [ones(row_validazione, 1), inputValidazione];
phi_blocchiDaUno_3grado_val = ones(row_validazione, numeroVariabili * gradoDesiderato);

k = 1;
for i= 1 : gradoDesiderato % la i serve a fare le potenze
    for j= 1 : numeroVariabili % mi aiuta a tener conto delle posizioni
        vect = phi_linear(:, j+1); % il +1 esclude il primo vettore di soli uni
        phi_blocchiDaUno_3grado_val(:, k) = vect.^i;
        k = k + 1;
    end
end

%% blocco da 2 pari validazione

phi_bloccoDaDuePrimo_3grado_val = ones(row_validazione,1); % giusto per ricordarmi che sono tot settimane
vect = 0;
k = 1;
for i= 1 : numeroVariabili
    for j= i+1 : numeroVariabili
        for z= 2: gradoDesiderato 
            if(mod(z, 2) == 0)
                vect = (phi_linear(:, i+1).^(z/2)).* phi_linear(:, j+1).^(z/2); 
                phi_bloccoDaDuePrimo_3grado_val(:, k) = vect;
                k = k+1;
            end
        end
    end
end

%% blocco da 2 dispari validazione

phi_bloccoDaDueSecondo_3grado_val = ones(row_validazione, 1);
c = 1;
contatore = 0;
for a= 1 : numeroVariabili
    for b= 1 : numeroVariabili
        if(a ~= b)
           for k= 1 : gradoDesiderato % da controllare con un if
                for j= k+1 : gradoDesiderato
                    %disp(j)
                    if(k+j <= gradoDesiderato)
                        vect = (phi_linear(:, a).^j).* phi_linear(:, b).^ k;
                        phi_bloccoDaDueSecondo_3grado_val(:, c) = vect;
                        c = c + 1;
                        contatore = contatore + 1;
                    end
                end
           end
        end
    end
end
disp(contatore)
phi_bloccoDaDue_3grado_val = [phi_bloccoDaDuePrimo_3grado_val, phi_bloccoDaDueSecondo_3grado_val];

%% blocco da 3 validazione

phi_bloccoDaTrePrimo_3grado_val = ones(row_validazione,1); % giusto per ricordarmi che sono tot settimane
vect = 0;
k = 1;
for a= 1 : numeroVariabili
    for b= a+1 : numeroVariabili
        for c= b+1 : numeroVariabili
           
            for z= 3: gradoDesiderato 
                if(mod(z, 3) == 0)
                    vect = (phi_linear(:, a+1).^(z/3)).* (phi_linear(:, b+1).^(z/3)).* phi_linear(:, c+1).^(z/3); 
                    phi_bloccoDaTrePrimo_3grado_val(:, k) = vect;
                    k = k+1;
                end
            end
            
        end
    end
end


%%

X_vect_val = 1:row_validazione;

phi_validazione_ar = inputValidazione;
phi_validazione_1 = [ones(row_validazione, 1), inputValidazione];
phi_validazione_2 = [ones(row_validazione, 1), phi_blocchiDaUno_2grado_val, phi_bloccoDaDuePrimo_2grado_val];
phi_validazione_3 = [ones(row_validazione, 1), phi_blocchiDaUno_3grado_val, phi_bloccoDaDue_3grado_val, phi_bloccoDaTrePrimo_3grado_val];

phi_linear_ar = inputIdentificazione;
phi_linear_1 = [ones(row_identificazione, 1), inputIdentificazione];
phi_linear_2 = [ones(row_identificazione, 1), phi_blocchiDaUno_2grado, phi_bloccoDaDuePrimo_2grado];
phi_linear_3 = [ones(row_identificazione, 1), phi_blocchiDaUno_3grado, phi_bloccoDaDue_3grado, phi_bloccoDaTrePrimo_3grado];

[theta_ar, std_ar] = lscov(phi_linear_ar, outputIdentificazione);
[theta_1, std_1] = lscov(phi_linear_1, outputIdentificazione);
[theta_2, std_2] = lscov(phi_linear_2, outputIdentificazione);
[theta_3, std_3] = lscov(phi_linear_3, outputIdentificazione);

model_gasST_group = [theta_1, std_1];

ordinataStimata_ar = phi_validazione_ar * theta_ar;
ordinataStimata_1 = phi_validazione_1 * theta_1;
ordinataStimata_2 = phi_validazione_2 * theta_2;
ordinataStimata_3 = phi_validazione_3 * theta_3;

figure(1)
plot(X_vect_val, outputValidazione, 'o');
hold on
grid on
plot(X_vect_val, ordinataStimata_ar, 'x');
legend('Dati veri', 'Previsioni')
title('Stima ar')
xlabel('Numero settimana')
ylabel('Valore gas')

figure(2)
xlabel('Numero settimana')
ylabel('Valore gas')
plot(X_vect_val, outputValidazione, 'o');
hold on
grid on
plot(X_vect_val, ordinataStimata_1, 'x');
legend('Dati veri', 'Previsioni')
title('Stima primo grado')
xlabel('Numero settimana')
ylabel('Valore gas')

figure(3)
plot(X_vect_val, outputValidazione, 'o');
hold on
grid on
plot(X_vect_val, ordinataStimata_2, 'x');
legend('Dati veri', 'Previsioni')
title('Stima secondo grado')
xlabel('Numero settimana')
ylabel('Valore gas')

figure(4)
plot(X_vect_val, outputValidazione, 'o');
hold on
grid on
plot(X_vect_val, ordinataStimata_3, 'x');
legend('Dati_veri', 'Previsioni')
title('Stima terzo grado')
xlabel('Numero settimana')
ylabel('Valore gas')

%% calcolo dei vari SSR ed MSE in identificazione
ordinataIdentificazione_ar = phi_linear_ar * theta_ar;
ordinataIdentificazione_1 = phi_linear_1 * theta_1;
ordinataIdentificazione_2 = phi_linear_2 * theta_2;
ordinataIdentificazione_3 = phi_linear_3 * theta_3;

residui_ar_identificazione = outputIdentificazione  - ordinataIdentificazione_ar; 
residui_1_identificazione = outputIdentificazione  - ordinataIdentificazione_1;
residui_2_identificazione = outputIdentificazione  - ordinataIdentificazione_2;
residui_3_identificazione = outputIdentificazione  - ordinataIdentificazione_3;

SSR_ar_identificazione = sum(residui_ar_identificazione.^2);
SSR_1_identificazione = sum(residui_1_identificazione.^2);
SSR_2_identificazione = sum(residui_2_identificazione.^2);
SSR_3_identificazione = sum(residui_3_identificazione.^2);

%% calcolo dei vari SSR ed MSE in validazione

residui_ar = outputValidazione - ordinataStimata_ar;
residui_quadrato_ar = residui_ar.^2;
SSR_ar = sum(residui_quadrato_ar);

residui_1 = outputValidazione - ordinataStimata_1;
residui_quadrato_1 = residui_1.^2;
SSR_1 = sum(residui_quadrato_1);
 
residui_2 = outputValidazione - ordinataStimata_2;
residui_quadrato_2 = residui_2.^2;
SSR_2 = sum(residui_quadrato_2);

residui_3 = outputValidazione - ordinataStimata_3;
residui_quadrato_3 = residui_3.^2;
SSR_3 = sum(residui_quadrato_3);

residui_ar_max = max(abs(residui_ar));
residui_1_max = max(abs(residui_1));
residui_2_max = max(abs(residui_2));
residui_3_max = max(abs(residui_3));

diff = outputValidazione - ordinataStimata_ar;
MSE_ar = mean(diff.^2);
diff = outputValidazione - ordinataStimata_1;
MSE_1 = mean(diff.^2);
diff = outputValidazione - ordinataStimata_2;
MSE_2 = mean(diff.^2);
diff = outputValidazione - ordinataStimata_3;
MSE_3 = mean(diff.^2);

%% intervalli di confidenza

[row_theta, column_theta] = size(theta_1);
n_meno_q = row_identificazione - row_theta;

t_critic = tinv(0.95, n_meno_q);

confInt = [(theta_1 - t_critic * std_1), (theta_1 + t_critic * std_1)];







