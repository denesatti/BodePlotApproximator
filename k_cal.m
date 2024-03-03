% This function caclulates the gain of the normalized transfer function

function k = k_cal(H,z,p)
    % We check for zeros in zero:
    if length(z) ~= 0
        for i = 1:length(z)
            if z(i) == 0
                z_k(i) = 1;
            else
                z_k(i) = z(i);
            end
        end
    else
        z_k = 1;
    end
    
    % We check for poles in zero
    if length(p) ~= 0
        for i = 1:length(p)
            if p(i) == 0
                p_k(i) = 1;
            else
                p_k(i) = p(i);
            end
        end
    else
        p_k = 1;
    end
    
    % We calculate the gain:
    k = H.K*prod(z_k)/prod(p_k);

end