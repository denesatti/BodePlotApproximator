% Function for plotting the magnitude approximations and the MATLAB approximated values:
function plot_mag(H,wma,m) 
    
    [m_b,f_b,w_b] = bode(H,{wma(1,1),wma(end,1)});
    
    figure;
    % Ploting the main bode plots
    semilogx(w_b,20*log10(squeeze(m_b)),"b");
    hold all;
    % Ploting the approximated points:
    for i=1:length(m)
        semilogx(wma(i,1),m(i),'ro', 'LineWidth',2);
    end
    % Ploting the approximated line
    semilogx(wma, m, 'r-', "LineWidth",2);
    hold off;
    legend("Bode()", "Approximated");
    title('Magnitude characteristics');
    grid;shg;

end