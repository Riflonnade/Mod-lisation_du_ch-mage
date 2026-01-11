function [p, sys_ode] = def_model_and_params()
% Définit les paramètres et le système dynamique. Sorties : p (Structure contenant toutes les constantes); sys_ode (equadiff régissant le système)

    % Définition des paramètres
    p.Lambda = 20;    p.d = 0.05;      p.alpha1 = 0.1;   p.beta1 = 0.001;
    p.gamma1 = 0.01;  p.delta = 0.05;  p.LambdaV = 10;   p.eta = 0.02;
    p.theta = 0.03;   p.mu = 0.1;      p.alpha2 = 0.05;  p.sigma = 0.05;

    % Définition du système
    sys_ode = @(t, x) equations_dynamiques(t, x, p);

end

function dxdt = equations_dynamiques(~, x, p)
    U = x(1); E = x(2); V = x(3); S = x(4);

    dU = p.Lambda - (p.d + p.alpha1)*U - p.beta1*U*V - p.gamma1*U*S + p.delta*E;
    dE = p.alpha1*U + p.beta1*U*V + p.gamma1*U*S - (p.d + p.delta)*E;
    dV = p.LambdaV + p.eta*E + p.theta*S - p.mu*V - p.beta1*U*V;
    dS = p.alpha2*U - (p.d + p.sigma)*S;

    dxdt = [dU; dE; dV; dS];
end