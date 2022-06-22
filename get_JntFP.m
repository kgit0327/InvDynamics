function JFP = get_JntFP(FN,n,mass,time_int,nFr)

% ä÷êﬂíÜêSÇÃë¨ìx
Jnt(1,3).v = dif3(n.wrR,nFr,time_int);
Jnt(1,2).v = dif3(n.elbR,nFr,time_int);
Jnt(1,1).v = dif3(n.shR,nFr,time_int);
Jnt(2,3).v = dif3(n.wrL,nFr,time_int);
Jnt(2,2).v = dif3(n.elbL,nFr,time_int);
Jnt(2,1).v = dif3(n.shL,nFr,time_int);
Jnt(3,3).v = dif3(n.anR,nFr,time_int);
Jnt(3,2).v = dif3(n.hipR,nFr,time_int);
Jnt(3,1).v = dif3(n.hipR,nFr,time_int);
Jnt(4,3).v = dif3(n.anL,nFr,time_int);
Jnt(4,2).v = dif3(n.knL,nFr,time_int);
Jnt(4,1).v = dif3(n.hipL,nFr,time_int);
Jnt(5,1).v = dif3(n.c,nFr,time_int);
Jnt(5,2).v = dif3(n.ribC,nFr,time_int);

    for iGrp = 1:5
        
        if iGrp == 5
            nJnt = 2;
        else
            nJnt = 3;
        end
        

        for iJnt = 1:nJnt
            
            Jnt(iGrp,iJnt).P = (FN(iGrp,iJnt).F.*Jnt(iGrp,iJnt).v)./mass;
            
        end
        
    end
                                           
JFP = [Jnt(1,1).P;...     %shR
       Jnt(1,2).P;...     %elbR
       Jnt(1,3).P;...     %wrR
       Jnt(2,1).P;...     %shL
       Jnt(2,2).P;...     %elbL
       Jnt(2,3).P;...     %wrL
       Jnt(3,1).P;...     %neck
       Jnt(3,2).P;...     %torso
       Jnt(3,3).P;...     %anR
       Jnt(4,1).P;...     %hipL
       Jnt(4,2).P;...     %knL
       Jnt(4,3).P;...     %anL
       Jnt(5,1).P;...     %neck
       Jnt(5,2).P;...     %ribC
                    ];
               
end
