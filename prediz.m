function m_hat = prediz(week)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

load model_gasST_group.mat;
load deviazione.mat;
load media.mat;

normalized_week = (week - media)/deviazione;

theta = model_gasST_group(:, 1);
std = model_gasST_group(:, 2);

phi = [1, normalized_week];
m_hat_normalized = phi * theta;

m_hat = (m_hat_normalized * deviazione) + media;

end

