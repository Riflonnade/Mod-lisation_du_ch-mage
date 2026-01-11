function analyse_stabilite(A, F_d)
% Vérifie la stabilité des systèmes continu et discret. Entrées : A (Jacobienne continue), F_d (Matrice d'état discrète)

    fprintf('\n> Modèle continu :\n');
    vp_cont = eig(A);
    
    fprintf('\n> Valeurs Propres :\n');
    disp(vp_cont);

    if all(real(vp_cont) < -1e-10)
        fprintf('  -> Résultat : Système Continu STABLE \n');
    else
        fprintf('  -> Résultat : Système Continu INSTABLE\n');
    end

    fprintf('\n> Modèle discret :\n');
    vp_disc = eig(F_d);
    
    fprintf('\n> Valeurs Propres :\n');
    disp(vp_disc); 

    if all(abs(vp_disc) < 1)
        fprintf('  -> Résultat : Système Discret STABLE \n');
    else
        fprintf('  -> Résultat : Système Discret INSTABLE\n');
    end
    
end