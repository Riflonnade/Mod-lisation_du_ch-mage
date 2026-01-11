clearvars; close all; clc;

fprintf('==============================================\n');
fprintf('     ANALYSE DU MODÈLE D''EMPLOYABILITÉ\n');
fprintf('==============================================\n');

[p, sys_ode] = def_model_and_params();

fprintf('\n--- A. Équilibre Analytique ---\n');
x_ana = eq_analytique(p);
disp('Résultat Analytique:'); disp(x_ana');

fprintf('\n--- B. Équilibre Numérique ---\n');
x_num = eq_numerique(sys_ode);
disp('Résultat Numérique:'); disp(x_num');

fprintf('\n--- Analyse de Sensibilité ---\n');
analyse_sensibilite(p, x_num);

fprintf('\n--- C. Discrétisation ---\n');

[F_d, G_d, A] = discretisation(p, x_num);

fprintf('\n--- D. Analyse de stabilité ---\n');
analyse_stabilite(A, F_d);

fprintf('\n--- E. Simulation ---\n');
tspan = [0 100];
%x_init = [80, 40, 90, 20];
%x_init = [80, 260, 40, 100];
x_init = [250, 15, 300,200 ];

% Simulation continue
[t, x_sim] = ode45(sys_ode, tspan, x_init);

% Simulation discrète 
k_steps = 0:1:100;
x_k = x_init(:) - x_num(:);
U_k_hist = zeros(1, length(k_steps));

for k = 1:length(k_steps)
    U_k_hist(k) = x_k(1) + x_num(1);
    x_k = F_d * x_k; 
end

% Graphiques
figure('Name', 'Résultats Complets', 'Color', 'W');

subplot(2,1,1);
plot(t, x_sim, 'LineWidth', 1.5);
legend('U (Chômeurs)', 'E (Employés)', 'V (Vacants)', 'S (Auto-Ent)');
title('Modèle continu'); grid on;

subplot(2,1,2);
plot(t, x_sim(:,1), 'b', 'LineWidth', 1.5); hold on;
stem(k_steps, U_k_hist, 'r.', 'LineWidth', 1);
legend('U Continu', 'U Discret (Linéarisé)');
title('Modèle Discret'); grid on;