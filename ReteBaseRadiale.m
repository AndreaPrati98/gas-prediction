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
spread = 150;  % spread constant / larghezza campana
MN = 6; % numero massimo di neuroni
DF = 1; % ogni quanti neuroni mostro mse


%%Inizializzo la rete
net = newrb(inputIdentificazione, outputIdentificazione, goal, spread, MN, DF);

predizione = sim(net, inputValidazione);
vectErrore = outputValidazione-predizione;
SSR = sum(vectErrore.^2);
deviation = std(vectErrore);

outString = sprintf("Neu: %d, Spread: %d, RSS: %1.6f, SD: %1.6f\n", MN, spread, SSR, deviation)

%Ricavo il grafico partendo dai dati di identificazione
predizioneId = sim(net, inputIdentificazione);

%%Plot delle previsioni normalizzate
figure(1)
subplot(1,2,1);
scatter(1:length(outputValidazione), outputValidazione, 'o');
hold on
scatter(1:length(outputValidazione), predizione, 'x');
hold off
legend('Dati veri','previsione')

subplot(1,2,2);
scatter(1:length(outputValidazione), vectErrore);
hold off
max(abs(vectErrore));
min(abs(vectErrore));

%%Plot delle previsioni denormalizzate
figure(2)
subplot(1,2,1);
scatter(1:length(outputValidazione), outputValidazione*deviazione+media, 'o');
hold on
scatter(1:length(outputValidazione), predizione*deviazione+media, 'x');
legend('Dati reali','previsione')
title('Previsione sui dati di validazione');

subplot(1,2,2);
scatter(1:length(outputValidazione), (outputValidazione*deviazione+media)-(predizione*deviazione+media));
title('Residui non normalizzati');

%%Plot della previsione in identificazione
figure(3);
plot(1:length(outputIdentificazione), outputIdentificazione);
hold on
plot(1:length(predizioneId), predizioneId);
title('Predizione della funzione in identificazione');
%view(net)

%%Plot dell'istogramma dei residui
figure(4);
vectDati = sort(vectErrore);

range = linspace(-0.3, 0.2, 20)
somme = zeros(length(range));
somme = somme(:, 1);

for j = 1:length(vectDati)
    for i = 1:length(range)
        if vectDati(j)<range(i)
            somme(i) = somme(i) + 1;
            break;
        end
    end
end
bar(range, somme, 0.9);
title('istogramma dei residui');