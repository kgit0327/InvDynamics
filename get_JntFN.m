function FN = get_JntFN(n,segdat,nFr,FP)

    
 for iFr=1:nFr
     
     GRF_L(:,iFr) = FP(1).grf(:,iFr);
     COP_L(:,iFr) = FP(1).cop(:,iFr);
     GRF_R(:,iFr) = FP(2).grf(:,iFr);
     COP_R(:,iFr) = FP(2).cop(:,iFr);
     FM_L(:,iFr) = FP(1).FM(:,iFr);
     FM_R(:,iFr) = FP(2).FM(:,iFr);

     %--------------------------------
     %group1
     %--------------------------------
     
     %handRÅ®wrR

     cg = segdat(1).cg(:,iFr);
     mg = segdat(1).mg(:,iFr);
     ma = segdat(1).ma(:,iFr);
     Ncg = segdat(1).N(:,iFr);
     distF = [0 0 0]';
     distN = [0 0 0]';
     rcgD = n.handR(:,iFr)-cg;
     rcgP = n.wrR(:,iFr)-cg;
     
     [FN(1,3).F(:,iFr),FN(1,3).N(:,iFr)] = getFN(Ncg,mg,ma,distF,distN,rcgD,rcgP);
     
     %farmRÅ®elbR
     
     cg = segdat(2).cg(:,iFr);
     mg = segdat(2).mg(:,iFr);
     ma = segdat(2).ma(:,iFr);
     Ncg = segdat(2).N(:,iFr);
     distF = -FN(1,3).F(:,iFr);
     distN = -FN(1,3).N(:,iFr);
     rcgD = n.wrR(:,iFr)-cg;
     rcgP = n.elbR(:,iFr)-cg;
     
     [FN(1,2).F(:,iFr),FN(1,2).N(:,iFr)] = getFN(Ncg,mg,ma,distF,distN,rcgD,rcgP);
          
     %uarmRÅ®shR

     cg = segdat(3).cg(:,iFr);
     mg = segdat(3).mg(:,iFr);
     ma = segdat(3).ma(:,iFr);
     Ncg = segdat(3).N(:,iFr);
     distF = -FN(1,2).F(:,iFr);
     distN = -FN(1,2).N(:,iFr);
     rcgD = n.elbR(:,iFr)-cg;
     rcgP = n.shR(:,iFr)-cg;
     
     [FN(1,1).F(:,iFr),FN(1,1).N(:,iFr)] = getFN(Ncg,mg,ma,distF,distN,rcgD,rcgP);
      
     %--------------------------------
     %group2
     %--------------------------------
     
     %handLÅ®wrL

     cg = segdat(4).cg(:,iFr);
     mg = segdat(4).mg(:,iFr);
     ma = segdat(4).ma(:,iFr);
     Ncg = segdat(4).N(:,iFr);
     distF = [0 0 0]';
     distN = [0 0 0]';
     rcgD = n.handL(:,iFr)-cg;
     rcgP = n.wrL(:,iFr)-cg;
     
     [FN(2,3).F(:,iFr),FN(2,3).N(:,iFr)] = getFN(Ncg,mg,ma,distF,distN,rcgD,rcgP);
    
     %farmLÅ®elb

     cg = segdat(5).cg(:,iFr);
     mg = segdat(5).mg(:,iFr);
     ma = segdat(5).ma(:,iFr);
     Ncg = segdat(5).N(:,iFr);
     distF = -FN(2,3).F(:,iFr);
     distN = -FN(2,3).N(:,iFr);
     rcgD = n.wrL(:,iFr)-cg;
     rcgP = n.elbL(:,iFr)-cg;
     
     [FN(2,2).F(:,iFr),FN(2,2).N(:,iFr)] = getFN(Ncg,mg,ma,distF,distN,rcgD,rcgP);
    
     %uarmLÅ®shL

     cg = segdat(6).cg(:,iFr);
     mg = segdat(6).mg(:,iFr);
     ma = segdat(6).ma(:,iFr);
     Ncg = segdat(6).N(:,iFr);
     distF = -FN(2,2).F(:,iFr);
     distN = -FN(2,2).N(:,iFr);
     rcgD = n.elbL(:,iFr)-cg;
     rcgP = n.shL(:,iFr)-cg;
     
     [FN(2,1).F(:,iFr),FN(2,1).N(:,iFr)] = getFN(Ncg,mg,ma,distF,distN,rcgD,rcgP);
    
     %--------------------------------
     %group3
     %--------------------------------
     
     %footRÅ®ankleR

     cg = segdat(7).cg(:,iFr);
     mg = segdat(7).mg(:,iFr);
     ma = segdat(7).ma(:,iFr);
     Ncg = segdat(7).N(:,iFr);
     distF = GRF_R(:,iFr);
     distN = FM_R(:,iFr);
     rcgD = COP_R(:,iFr)-cg;
     rcgP = n.anR(:,iFr)-cg;
     
     [FN(3,3).F(:,iFr),FN(3,3).N(:,iFr)] = getFN(Ncg,mg,ma,distF,distN,rcgD,rcgP);
     
     %shankRÅ®kneeR
 
     cg = segdat(8).cg(:,iFr);
     mg = segdat(8).mg(:,iFr);
     ma = segdat(8).ma(:,iFr);
     Ncg = segdat(8).N(:,iFr);
     distF = -FN(3,3).F(:,iFr);
     distN = -FN(3,3).N(:,iFr);
     rcgD = n.anR(:,iFr)-cg;
     rcgP = n.knR(:,iFr)-cg;
     
     [FN(3,2).F(:,iFr),FN(3,2).N(:,iFr)] = getFN(Ncg,mg,ma,distF,distN,rcgD,rcgP);
     
     %thighRÅ®hipR
      
     cg = segdat(9).cg(:,iFr);
     mg = segdat(9).mg(:,iFr);
     ma = segdat(9).ma(:,iFr);
     Ncg = segdat(9).N(:,iFr);
     distF = -FN(3,2).F(:,iFr);
     distN = -FN(3,2).N(:,iFr);
     rcgD = n.knR(:,iFr)-cg;
     rcgP = n.hipR(:,iFr)-cg;
     
     [FN(3,1).F(:,iFr),FN(3,1).N(:,iFr)] = getFN(Ncg,mg,ma,distF,distN,rcgD,rcgP);
            
     %--------------------------------
     %group4
     %--------------------------------

     %footLÅ®ankleL
 
     cg = segdat(10).cg(:,iFr);
     mg = segdat(10).mg(:,iFr);
     ma = segdat(10).ma(:,iFr);
     Ncg = segdat(10).N(:,iFr);
     distF = GRF_L(:,iFr);
     distN = FM_L(:,iFr);
     rcgD=COP_L(:,iFr)-cg;
     rcgP=n.anL(:,iFr)-cg;
     
     [FN(4,3).F(:,iFr),FN(4,3).N(:,iFr)]=getFN(Ncg,mg,ma,distF,distN,rcgD,rcgP);
     
     %shankLÅ®kneeL
 
     cg = segdat(11).cg(:,iFr);
     mg = segdat(11).mg(:,iFr);
     ma = segdat(11).ma(:,iFr);
     Ncg = segdat(11).N(:,iFr);
     distF = -FN(4,3).F(:,iFr);
     distN = -FN(4,3).N(:,iFr);
     rcgD = n.anL(:,iFr)-cg;
     rcgP = n.knL(:,iFr)-cg;
     
     [FN(4,2).F(:,iFr),FN(4,2).N(:,iFr)] = getFN(Ncg,mg,ma,distF,distN,rcgD,rcgP);
     
     %thighLÅ®hipL
 
     cg = segdat(12).cg(:,iFr);
     mg = segdat(12).mg(:,iFr);
     ma = segdat(12).ma(:,iFr);
     Ncg = segdat(12).N(:,iFr);
     distF = -FN(4,2).F(:,iFr);
     distN = -FN(4,2).N(:,iFr);
     rcgD = n.knL(:,iFr)-cg;
     rcgP = n.hipL(:,iFr)-cg;
     
     [FN(4,1).F(:,iFr),FN(4,1).N(:,iFr)] = getFN(Ncg,mg,ma,distF,distN,rcgD,rcgP);
      
     %--------------------------------
     %group5
     %-------------------------------- 
    
     %HeadÅ®Neck
     
     cg = segdat(13).cg(:,iFr);
     mg = segdat(13).mg(:,iFr);
     ma = segdat(13).ma(:,iFr);
     Ncg = segdat(13).N(:,iFr);
     distF = [0;0;0];
     distN = [0;0;0];
     rcgD = n.head(:,iFr)-cg;
     rcgP = n.c(:,iFr)-cg;
     
     [FN(5,1).F(:,iFr),FN(5,1).N(:,iFr)] = getFN(Ncg,mg,ma,distF,distN,rcgD,rcgP);
      
    %corpÅ®ribC  corpus sterni(ãπçúëÃ)
    
    cg = segdat(14).cg(:,iFr);
    mg = segdat(14).mg(:,iFr);
    ma = segdat(14).ma(:,iFr);
    Ncg = segdat(14).N(:,iFr);
    
    distF = -FN(5,1).F(:,iFr);
    distN = -FN(5,1).N(:,iFr);
    distFR = -FN(1,1).F(:,iFr);
    distNR = -FN(1,1).N(:,iFr);
    distFL = -FN(2,1).F(:,iFr);
    distNL = -FN(2,1).N(:,iFr);
    
    FN(5,2).F(:,iFr) = ma-mg-distFR-distFL-distF;
    
    rnec = n.c(:,iFr)-cg;
    rsR = n.shR(:,iFr)-cg;
    rsL = n.shL(:,iFr)-cg;
    rupt = n.ribC(:,iFr)-cg;
    
    FN(5,2).N(:,iFr)=Ncg-cross(rsL,distFL)-cross(rsR,distFR)...
                    -cross(rupt,FN(5,2).F(:,iFr))-cross(rnec,distF)...
                    -distNR-distNL-distN;
                
                
 %FN     1                         2                           3          
 %1  (shRÇÃF,N)                (elRÇÃF,N)                 (wrRÇÃF,N)
 %2  (shLÇÃF,M)                (elbLÇÃF,M)                (wrLÇÃF,M)
 %3  (hipRÇÃF,N)               (knRÇÃF,N)                 (anRÇÃF,N)
 %4  (hipLÇÃF,M)               (knLÇÃF,M)                 (anLÇÃF,M)
 %5  (neckÇÃF,N)               (ribCÇÃF,N)
 
 end
     
end

function [F,N] = getFN(Ncg,mg,ma,distF,distN,rcgD,rcgP)

	F = ma-mg-distF;
	N = Ncg-distN-cross(rcgP,F)-cross(rcgD,distF);

end

