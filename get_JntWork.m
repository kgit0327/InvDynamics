function  JW = get_JntWork(JFP,JTP,time_int)

%% (Joint work for JTP) --------------------------------------------

[npoint,nFr] = size(JTP);

for iaxis = 1:npoint
    
    for iFr = 1:nFr
        
        if JTP(iaxis,iFr) > 0
            pos(iaxis,iFr) = JTP(iaxis,iFr);
        else
            pos(iaxis,iFr) = 0;
        end
        
        if  JTP(iaxis,iFr) <= 0
            neg(iaxis,iFr) = JTP(iaxis,iFr);
        else
            neg(iaxis,iFr) = 0;
        end
        
    end
    
end

JW.pos = simpson(pos,time_int);
JW.neg = simpson(neg,time_int);
JW.total = simpson(JTP,time_int);

%% (Joint work for JFP) --------------------------------------------

for iaxis = 1:npoint
    
    for iFr = 1:nFr
        
        if JFP(iaxis,iFr) > 0
            posF(iaxis,iFr) = JFP(iaxis,iFr);
        else
            posF(iaxis,iFr) = 0;
        end
        
        if  JFP(iaxis,iFr) <= 0
            negF(iaxis,iFr) = JFP(iaxis,iFr);
        else
            negF(iaxis,iFr) = 0;
        end
        
    end
    
end

JW.posF = simpson(posF,time_int);
JW.negF = simpson(negF,time_int);
JW.totalF = simpson(JFP,time_int);

end

