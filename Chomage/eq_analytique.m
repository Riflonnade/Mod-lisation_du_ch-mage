function x_star = eq_analytique(p)
% Résolution mathématique en se ramenant à un polynôme : Entrée : p (paramètres) Sortie : x_star (vecteur équilibre [U; E; V; S])

    K = p.Lambda / p.d; 
    ks = p.alpha2 / (p.d + p.sigma);
    cd = p.d + p.delta; 

    An = -p.gamma1 * ks;
    Bn = -(cd + p.alpha1);
    Cn = cd * K;

    Az = p.theta * ks - p.eta;
    Bz = p.LambdaV + p.eta * K;

    c3 = -p.beta1 * An; 
    c2 = p.beta1 * Az - p.mu * An - p.beta1 * Bn;
    c1 = p.beta1 * Bz - p.mu * Bn - p.beta1 * Cn;
    c0 = -p.mu * Cn;

    % Résolution
    poly_coeffs = [c3, c2, c1, c0];
    racines = roots(poly_coeffs);

    U_star = racines(imag(racines)==0 & racines>0 & racines<K);

    if isempty(U_star)
        error('Pas de solution analytique trouvée.');
    end
    
    U_star = U_star(1);

    % Calcul des autres variables à partir de U*
    S_star = ks * U_star;
    E_star = K - U_star;
    V_star = (An*U_star^2 + Bn*U_star + Cn) / (p.beta1 * U_star);
    
    x_star = [U_star; E_star; V_star; S_star];
    
    fprintf('Polynôme résolu : %.4f U^3 + %.4f U^2 + %.4f U + %.4f = 0\n', ...
        poly_coeffs(1), poly_coeffs(2), poly_coeffs(3), poly_coeffs(4));
end
