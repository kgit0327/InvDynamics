function JA = modifyJA(JA)

%関節角度の修正。
%関節角度の符号が変わる際の異常値の修正

	[~,nFr] = size(JA);
            
    for iFr = 1:nFr-1
        
        if JA(iFr)-JA(iFr+1) >= 0.95*pi
            JA(iFr+1) = JA(iFr+1)+pi;
        elseif JA(iFr)-JA(iFr+1) <= -0.95*pi
            JA(iFr+1) = JA(iFr+1)-pi;
        else
            JA(iFr+1) = JA(iFr+1);
        end
    
    end
    
end