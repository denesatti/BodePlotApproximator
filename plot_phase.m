% Function for plotting the phase approximations and the MATLAB approximated values:
function plot_phase(H, wma)
    [mag,pha,wout] = bode(H, {min(wma(:,1)), max(wma(:,1))});
    pha = squeeze(pha);
    figure
    semilogx(wout,pha,"b");
    hold on
    for i = 1:length(wma)
        semilogx(wma(i,1),wma(i,2),'ro', 'LineWidth',2)
    end
    semilogx(wma(:,1),wma(:,2),'r-', "LineWidth",2);
    hold off;
    legend("Bode()", "Approxiomated")
    title("Phase characteristics:")
    grid;shg;
end
