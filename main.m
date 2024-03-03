% Bode magnmitude and phase characteristics apporximator
clear all; close all; clc;

% Define the transfer functions:
H_a(1) = zpk([],[-3], 10);                  %a)
H_a(2) = zpk([-70],[-20],0.2);              %b)
H_a(3) = zpk([0],[-7],2);                   %c)
H_a(4) = zpk([],[0 -7],20);                 %d)
H_a(5) = zpk([],[0 -1/7],5/7);              %e)
H_a(6) = zpk([],[-1 -10],75);               %f)
H_a(7) = zpk([-2],[-1/3 -1/2], 2/6);        %g)
H_a(8) = zpk([-1/10],[-1/3 -1/2], 2*10/6);  %h)
H_a(9) = zpk([-2],[-5, -10], 20);           %i)

%Iterating trough them
for id = 1:9
    H = H_a(id);

% define the freq. boundaries:
    wmin =-1;
    wmax = 3;

% Approximating the gain:

    % Reading the zeros and the poles:
    z = abs(cell2mat(H.Z));
    p = abs(cell2mat(H.P));
    
    % Calculating the gain:
    k = k_cal(H,z,p);
    
    % Calculating the freq. of the approximation points:
    wma = wma_cal(z,p,k, wmin, wmax);
    
    %Calculating the magnitudes of the approx. points:
    %Due to the structure of it, wma needs to be also changed when 
    % we have zeros/poles in 0
    m = zeros(length(wma)-1,1);
    [m,wma] = mag_cal(wma,m,k,wmin);
    
    % Ploting the magnitudes and the phases: 
    plot_mag(H,wma,m);

% Approximating the phase:
    wma = calcphase(H,10^wmin,10^wmax);
    
    plot_phase(H,wma);

end
