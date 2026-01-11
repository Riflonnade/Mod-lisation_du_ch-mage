
function x_eq = eq_numerique(sys_ode)
% Recherche du point d'équilibre avec fsolve. Entrée : sys_ode (système) Sortie : x_eq 

    x0 = [2400000, 30400000,458000, 4400000]; % Point de départ arbitraire
    options = optimset('Display', 'off', 'TolFun', 1e-10);

    % Résolution
    [x_eq, ~, exitflag] = fsolve(@(x) sys_ode(0, x), x0, options);

    if exitflag <= 0
        warning('La recherche numérique du point d''équilibre a échoué.');
        x_eq = [NaN; NaN; NaN; NaN];
    end
    
end