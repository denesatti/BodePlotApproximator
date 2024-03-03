% Function for caclulating the phase at different meaningful frequencies
function wma_out = calcphase(H,wmin,wmax)
    z = abs(cell2mat(H.Z));
    p = abs(cell2mat(H.P));
    k = k_cal(H,z,p);
    
    wma = wma_init_gen(H,wmin,wmax); 
    
    wma_z = wma;
    w_z = wma;
    wma_p = wma;
    w_p = wma;
    % Calc for zeros
    if isempty(z) 
        % calc for konst
        if k < 0
            wma_z(:,2) = wma_z(:,2)*pi;
        else 
            wma_z = wma_z;
        end
    else 
        % Calc for z in origin
        for l=1:length(z)
            if isempty(find(~z))
                index_start = find(wma_z(:,1) == min(z)*0.1);
                %the larges zero*10s position in wma
                index_finish = find(wma_z(:,1) == max(z)*10); 
                wma_z(index_finish,2) = 90*length(z);
                
                i = index_finish-1
                while i >= index_start
                    wma_z(i,2) = wma_z(i+1,2)-45*length(z)*(log10(wma_z(i+1,1)/wma_z(i,1)));
                    i = i - 1;
                end
                
                wma_z(index_finish:end,2) = wma_z(index_finish,2);
                    
            else
            % Calc for z in origin
                wma_z(:,2) = wma_z(:,2)+90*length(find(~z));
            end
            w_z(:,2) =w_z(:,2) + wma_z(:,2);

        end
    end

    % Calc for poles:
    if isempty(p) 
        % calc for konst
        if k < 0
            wma_p(:,2) = wma_p(:,2)*pi;
        else 
            wma_p = wma_p;
        end
    else 
        % Calc for p in origin
        for l = 1:length(p)
            if find(p(l))
                index_start = find(wma_p(:,1) == min(p)*0.1);
                %the larges zero*10s position in wma
                index_finish = find(wma_p(:,1) == max(p)*10); 
                wma_p(index_finish,2) = -90*length(p);

                i = index_finish-1;
                while i >= index_start+1
                    wma_p(i,2) = wma_p(i+1,2)+45*length(p)*(log10(wma_p(i+1,1)/wma_p(i,1)));
                    i = i - 1;
                end
                
                wma_p(index_finish:end,2) = wma_p(index_finish,2);
                    
            else
            % Calc for z in origin
               wma_p(:,2) = wma_p(:,2)-90*length(find(~p));
            end
            
        end
    end

    
    wma_out = [wma_z(:,1), wma_z(:,2) + wma_p(:,2)]; 
end