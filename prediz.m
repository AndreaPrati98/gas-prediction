function m_hat = prediz(week)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

load model_gasST_group.mat;


theta = model_gasST_group(:, 1);
std = model_gasST_group(:, 2);

phi = [1, week];
m_hat = phi * theta;

end

