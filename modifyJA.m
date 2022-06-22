function JA = modifyJA(JA)

%ŠÖßŠp“x‚ÌC³B
%ŠÖßŠp“x‚Ì•„†‚ª•Ï‚í‚éÛ‚ÌˆÙí’l‚ÌC³

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