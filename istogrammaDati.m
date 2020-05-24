clc
clear

load gasDataSet.mat;
xString = 'giornoAnno';
yString = 'giornoSettimana';
zString = 'dati';
gasDataSet.Properties.VariableNames = {xString, yString, zString};

vectGiornoAnno = gasDataSet.giornoAnno;
vectGiornoSettimana = gasDataSet.giornoSettimana;
vectDati = gasDataSet.dati;
vectDati = sort(vectDati);

range = linspace(0, 250, 26);
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

figure(1);
bar(range, somme, 0.9);
title('Istogramma valori di gas');
xlabel('Valori possibili assunti dal gas')
ylabel('Numero di volte che viene assunto il valore sulla x')
%'FaceColor', '#EDB120' 

