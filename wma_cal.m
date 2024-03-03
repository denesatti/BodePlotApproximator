% Function for obtaining wma
% (Doing some magic to get wma matrix with more info)\
% wma has 2 columns
% col1 is the actuall frw. value
% col2 hold info of the slop, can be:  0, 1, -1 
function wma = wma_cal(z,p,k, wmin, wmax)
    % We initialy define wma as [wmin, 0; wmin*10, 0 ;...; wmax, 0]
    aux = wmin:wmax;
    wma = 10.^aux;
    wma = [wma' zeros(length(wma),1)];
    
    %adding zeros and poles to wma
    z = [z ones(length(z),1)];
    p = [p ones(length(p),1)*(-1)];
    zap   = [z; p];
    zap   = sortrows(zap);
    wma = [wma ; zap];
    
    % Sorting wma
    wma = sortrows(wma);
    
    % if we have zeros/poles in 10^n we have to remove the rove above/below
    % so we dont have unneccesary values in wma
    for i= 1:length(wma)-1
        if wma(i,1) == wma(i+1,1)
            if wma(i,2) == 0
                wma = [wma(1:i-1,:); wma(i+1:end,:)];
            else
                 wma = [wma(1:i,:); wma(i+2:end,:)];
            end    
            break
        end
    end
end
