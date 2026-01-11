function [F_d, G_d, A] = discretisation(p, x_eq)
% Linearisation et calcul des matrices pour le modèle discret. Entrées : p (paramètres), x_eq (point d'équilibre) Sorties : F_d, G_d (Discret), A (Continu/Jacobienne)

    U = x_eq(1); V = x_eq(3); S = x_eq(4);

    % Calcul de la Jacobienne
    A = zeros(4,4);
    A(1,1) = -(p.d + p.alpha1 + p.beta1*V + p.gamma1*S); 
    A(1,2) = p.delta; A(1,3) = -p.beta1*U; A(1,4) = -p.gamma1*U;

    A(2,1) = (p.alpha1 + p.beta1*V + p.gamma1*S);        
    A(2,2) = -(p.d + p.delta); A(2,3) = p.beta1*U;  
    A(2,4) = p.gamma1*U;

    A(3,1) = -p.beta1*V;                                 
    A(3,2) = p.eta;            
    A(3,3) = -(p.mu + p.beta1*U); 
    A(3,4) = p.theta;
    
    A(4,1) = p.alpha2;                                                  
    A(4,4) = -(p.d + p.sigma);

    % Discrétisation 
    Ts = 1; % Période d'échantillonnage
    B = [0; 0; 1; 0]; % Vecteur d'entrée sur V
    
    F_d = expm(A*Ts);
    G_d = A \ (F_d - eye(4)) * B;
end