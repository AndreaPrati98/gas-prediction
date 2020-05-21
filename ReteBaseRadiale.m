clc
clear

load inputIdentificazione;
load outputIdentificazione;
load inputValidazione;
load outputValidazione;
load media;
load deviazione;

inputIdentificazione = inputIdentificazione';
outputIdentificazione = outputIdentificazione';
inputValidazione = inputValidazione';
outputValidazione = outputValidazione';

settimaneIdentificazione = 74;
settimaneValidazione = 30;

goal = 0.0; % sum-squared error goal
spread = 250;  % spread constant / larghezza campana
MN = 7; % numero massimo di neuroni
DF = 1; % ogni quanti neuroni mostro mse

sum = 0;

net = newrb(inputIdentificazione, outputIdentificazione, goal, spread, MN, DF);
for i = 1:settimaneValidazione
    inputSettimana = inputValidazione(:, i);
    if i == 1
        predizione = sim(net, inputSettimana);
        outputVero = outputValidazione(1,i);
        errore = outputVero - predizione;
        vectErrore = errore;
        sum = (errore)^2;
    elseif(i < settimaneValidazione)
        predizione = [predizione, sim(net, inputSettimana)];
        outputVero = [outputVero, outputValidazione(1,i)];
        errore = outputVero(i) - predizione(i);
        vectErrore = [vectErrore, errore];
        sum = sum + (outputVero(i)-predizione(i))^2;
    end 

end

deviation = std(vectErrore);

outString = sprintf("Neu: %d, Spread: %d, RSS: %1.6f, SD: %1.6f\n", MN, spread, sum, deviation)

figure(1)
subplot(1,2,1);
plot(1:length(outputVero), outputVero);
hold on
plot(1:length(outputVero), predizione);
hold off
legend('Dati reali','previsione')

subplot(1,2,2);
plot(1:length(outputVero), vectErrore);
hold off
max(abs(vectErrore));
min(abs(vectErrore));

% %denormalizzo
% figure(2)
% subplot(1,2,1);
% plot(1:length(outputVero), outputVero*deviazione+media);
% hold on
% plot(1:length(outputVero), predizione*deviazione+media);
% legend('Dati reali','previsione')
% 
% subplot(1,2,2);
% plot(1:length(outputVero), vectErrore);