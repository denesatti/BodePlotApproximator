% This function calculates and intializes the array of frequencies for
% which the magnitude approximation points will be drawn
function wma_init  = wma_init_gen(H, wmin, wmax)
    z = abs(cell2mat(H.Z));
    p = abs(cell2mat(H.P)); 
    
    aux = [0.1 1 10]';
    wma = [wmin; wmax];

    if ~isempty(z)
        wma = [wma; reshape(z.*aux,[],1)];
    end
    if ~isempty(p)
        for i = 1:length(p)
            wma = [wma; reshape(p(i).*aux,[],1)];
        end
    end
    wma = sortrows(wma);
    display(wma);
    if ~isempty(max(find(~wma)))
        wma = wma(max(find(~wma)) + 1:end);
    end
    % due to some computational deviance we need to give a tolerance 
    % to get unique value  
    wma = uniquetol(wma,1e-15);

    wma_init =[wma, zeros(length(wma),1)];

end