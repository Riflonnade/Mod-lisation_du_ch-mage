function analyse_sensibilite(p, x_ref)
% Calcule l'impact des variations de paramètres. Entrées : p (paramètres de base), x_ref (équilibre de référence)

    
    params_list = fieldnames(p); 
    T_ref = x_ref(1) / (x_ref(1) + x_ref(2) + x_ref(4)); % Taux chômage ref

    fprintf('%-10s | %-12s | %-12s | %-10s\n', 'Param', 'Valeur Init', 'Var T* (%)', 'Indice S');
    fprintf('----------------------------------------------------------\n');

    options = optimset('Display', 'off', 'TolFun', 1e-10);

    for i = 1:length(params_list)
        param_name = params_list{i};
        val_init = p.(param_name);
        
        % Perturbation
        p_sens = p; 
        p_sens.(param_name) = val_init * 1.10; 
        
        % Redéfinition du système avec les nouveaux paramètres
        sys_sens = @(x) [ ...
            p_sens.Lambda - (p_sens.d + p_sens.alpha1)*x(1) - p_sens.beta1*x(1)*x(3) - p_sens.gamma1*x(1)*x(4) + p_sens.delta*x(2); ...
            p_sens.alpha1*x(1) + p_sens.beta1*x(1)*x(3) + p_sens.gamma1*x(1)*x(4) - (p_sens.d + p_sens.delta)*x(2); ...
            p_sens.LambdaV + p_sens.eta*x(2) + p_sens.theta*x(4) - p_sens.mu*x(3) - p_sens.beta1*x(1)*x(3); ...
            p_sens.alpha2*x(1) - (p_sens.d + p_sens.sigma)*x(4) ...
        ];

        % Résolution
        [x_new, ~, exitflag] = fsolve(sys_sens, x_ref, options);
        
        if exitflag > 0
            T_new = x_new(1)/(x_new(1)+x_new(2)+x_new(4));
            delta_pct = (T_new - T_ref) / T_ref * 100;
            sensib = (delta_pct/100) / 0.10;
            
            fprintf('%-10s | %-12.4f | %+7.2f%%     | %+7.2f\n', ...
                param_name, val_init, delta_pct, sensib);
        else
            fprintf('%-10s | Erreur convergence\n', param_name);
        end
    end
end