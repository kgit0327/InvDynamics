
HM = [1.655 1.663 1.681 1.735 1.625 1.650];
M = [62.5 63.1 66.8 71.3 56.8 60.1];

for isub = 1:6
    
    for icond = 1:3
        
        for itrial = 1:20
            
            SNM = {'sub_A';'sub_B';'sub_C';'sub_D';'sub_E';'sub_F'};
            CNM = {' Fast ';'Medium';' Slow '};
            SN = char(SNM(isub,:));
            FN = [SN,'_',char(CNM(icond,1)),num2str(itrial)];
            Height = HM(1,isub);
            Mass = M(1,isub);
            
        end
        
    end
    
end