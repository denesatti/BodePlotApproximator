% Function for calculating the magnitudes:
function [m,wma] = mag_cal(wma,m,k,wmin)
    coeff = wma(1,2)*20;
    % Checking if there are zeros
    if wma(1,1) == 0
        m(1) = 20*(log10(k))*(abs(wmin)+2);
        wma = wma(2:end,:);
    else
        coeff = 0;
        m(1) = 20*log10(k);
    end
    
    % Calculating the magintudes
    for i = 2:length(wma)
        coeff = coeff + wma(i-1,2)*20;
        m(i) = m(i-1) + coeff*log10(wma(i,1)/wma(i-1,1));

    end
end