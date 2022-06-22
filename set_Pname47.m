function n = set_Pname47(dat)

%----------------------------------------------------------------
%äeéÌç¿ïWñºÇéwíË
%----------------------------------------------------------------

id = set_id47;

%âEòr
n.handR = dat(3*(id.handR -1)+1:3*id.handR ,:);       
n.wrRI = dat(3*(id.wrRI -1)+1:3*id.wrRI ,:);
n.wrRO = dat(3*(id.wrRO -1)+1:3*id.wrRO ,:);
n.elbRI = dat(3*(id.elbRI -1)+1:3*id.elbRI ,:);
n.elbRO = dat(3*(id.elbRO -1)+1:3*id.elbRO ,:);
n.shRF = dat(3*(id.shRF -1)+1:3*id.shRF ,:);
n.shRB = dat(3*(id.shRB -1)+1:3*id.shRB ,:);
n.shRU = dat(3*(id.shRU -1)+1:3*id.shRU ,:);

%ç∂òr
n.handL = dat(3*(id.handL -1)+1:3*id.handL ,:);
n.wrLI = dat(3*(id.wrLI -1)+1:3*id.wrLI ,:);
n.wrLO = dat(3*(id.wrLO -1)+1:3*id.wrLO ,:);
n.elbLI = dat(3*(id.elbLI -1)+1:3*id.elbLI ,:);
n.elbLO = dat(3*(id.elbLO -1)+1:3*id.elbLO ,:);
n.shLF = dat(3*(id.shLF -1)+1:3*id.shLF ,:);
n.shLB = dat(3*(id.shLB -1)+1:3*id.shLB ,:);
n.shLU = dat(3*(id.shLU -1)+1:3*id.shLU ,:);

%âEãr
n.toeR = dat(3*(id.toeR -1)+1:3*id.toeR ,:);
n.baRI = dat(3*(id.baRI -1)+1:3*id.baRI ,:);
n.baRO = dat(3*(id.baRO -1)+1:3*id.baRO ,:);
n.heelR = dat(3*(id.heelR -1)+1:3*id.heelR ,:);
n.anRI = dat(3*(id.anRI -1)+1:3*id.anRI ,:);
n.anRO = dat(3*(id.anRO -1)+1:3*id.anRO ,:);
n.knRI = dat(3*(id.knRI -1)+1:3*id.knRI ,:);
n.knRO = dat(3*(id.knRO -1)+1:3*id.knRO ,:);
n.troR = dat(3*(id.troR -1)+1:3*id.troR ,:);

%ç∂ãr
n.toeL = dat(3*(id.toeL -1)+1:3*id.toeL ,:);
n.baLI = dat(3*(id.baLI -1)+1:3*id.baLI ,:);
n.baLO = dat(3*(id.baLO -1)+1:3*id.baLO ,:);
n.heelL = dat(3*(id.heelL -1)+1:3*id.heelL ,:);
n.anLI = dat(3*(id.anLI -1)+1:3*id.anLI ,:);
n.anLO = dat(3*(id.anLO -1)+1:3*id.anLO ,:);
n.knLI = dat(3*(id.knLI -1)+1:3*id.knLI ,:);
n.knLO = dat(3*(id.knLO -1)+1:3*id.knLO ,:);
n.troL = dat(3*(id.troL -1)+1:3*id.troL ,:);

%ëÃä≤
n.head = dat(3*(id.head -1)+1:3*id.head ,:);
n.earR = dat(3*(id.earR -1)+1:3*id.earR ,:);
n.earL = dat(3*(id.earL -1)+1:3*id.earL ,:);
n.clav = dat(3*(id.clav -1)+1:3*id.clav ,:);
n.c7 = dat(3*(id.c7 -1)+1:3*id.c7 ,:);
n.ribR = dat(3*(id.ribR -1)+1:3*id.ribR ,:);
n.ribL = dat(3*(id.ribL -1)+1:3*id.ribL ,:);
n.xiph = dat(3*(id.xiph -1)+1:3*id.xiph ,:);
n.t10 = dat(3*(id.t10 -1)+1:3*id.t10 ,:);
n.ASISR = dat(3*(id.ASISR -1)+1:3*id.ASISR ,:);
n.ASISL = dat(3*(id.ASISL -1)+1:3*id.ASISL ,:);
n.PSISR = dat(3*(id.PSISR -1)+1:3*id.PSISR ,:);
n.PSISL = dat(3*(id.PSISL -1)+1:3*id.PSISL ,:);

%ä÷êﬂíÜêSç¿ïWéZèo-----------------------------------------------------------

%òr
n.wrR = (n.wrRI+n.wrRO)/2;
n.elbR = (n.elbRI+n.elbRO)/2;
n.shR = (n.shRF+n.shRB)/2;
n.wrL = (n.wrLI+n.wrLO)/2;
n.elbL = (n.elbLI+n.elbLO)/2;
n.shL = (n.shLF+n.shLB)/2;

%ãr
n.baR = (n.baRI+n.baRO)/2;
n.anR = (n.anRI+n.anRO)/2;
n.knR = (n.knRI+n.knRO)/2;
n.baL = (n.baLI+n.baLO)/2;
n.anL = (n.anLI+n.anLO)/2;
n.knL = (n.knLI+n.knLO)/2;

n.ASISC = (n.ASISR+n.ASISL)/2;
n.PSISC = (n.PSISR+n.PSISL)/2;
n.APSISR = (n.ASISR+n.PSISR)/2;
n.APSISL = (n.ASISL+n.PSISL)/2;

n.shC = (n.shR+n.shL)/2;
n.ear = (n.earR+n.earL)/2;
n.pelC = (n.ASISC+n.PSISC)/2;
n.troC = (n.troR+n.troL)/2;

%å“ä÷êﬂíÜêS Harrington et al., JB, (2007) éQè∆----------------------------------------------------------

 %çúî’ç¿ïWåníËã`
 
 x_pel = unitvec(n.ASISR-n.ASISL);
 s_pel = unitvec(n.ASISC-n.PSISC);
 z_pel = unitvec(cross(x_pel,s_pel));
 y_pel = unitvec(cross(z_pel,x_pel));
        
 V_PW = (n.ASISR-n.ASISL); 
 V_PD = (n.ASISC-n.PSISC);         
 V_LLR1 = (n.knRI-n.anRI);         
 V_LLR2 = (n.ASISR-n.knRI);
 V_LLL1 = (n.knLI-n.anLI);
 V_LLL2 = (n.ASISL-n.knLI);
       
 PW = ones(length(V_PW(:,1)),1)*sqrt(sum(V_PW.*V_PW)); 
 PD = ones(length(V_PD(:,1)),1)*sqrt(sum(V_PD.*V_PD)); 
 LLR1 = ones(length(V_LLR1(:,1)),1)*sqrt(sum(V_LLR1.*V_LLR1));
 LLR2 = ones(length(V_LLR2(:,1)),1)*sqrt(sum(V_LLR2.*V_LLR2));
 LLL1 = ones(length(V_LLL1(:,1)),1)*sqrt(sum(V_LLL1.*V_LLL1));
 LLL2 = ones(length(V_LLL2(:,1)),1)*sqrt(sum(V_LLL2.*V_LLL2));
       
 LLR = LLR1+LLR2;
 LLL = LLL1+LLL2;
       
 nFr = length(n.handR);

 for iFr = 1:nFr
               
     n.hipR(:,iFr) = n.ASISC(:,iFr)+(0.28*PD(:,iFr).*x_pel(:,iFr)+0.16*PW(:,iFr).*x_pel(:,iFr)+0.0079)...
                   +(-0.24*PD(:,iFr).*y_pel(:,iFr)-0.0099)...
                   +(-0.16*PW(:,iFr).*z_pel(:,iFr)-0.04*LLR(:,iFr).*z_pel(:,iFr)-0.0071); 
        
     n.hipL(:,iFr) = n.ASISC(:,iFr)+(-0.28*PD(:,iFr).*x_pel(:,iFr)-0.16*PW(:,iFr).*x_pel(:,iFr)-0.0079)...
                   +(-0.24*PD(:,iFr).*y_pel(:,iFr)-0.0099)...
                   +(-0.16*PW(:,iFr).*z_pel(:,iFr)-0.04*LLL(:,iFr).*z_pel(:,iFr)-0.0071); 
              
 end

%ëÃä≤âºëzä÷êﬂíÜêS à¢ç] (1992) éQè∆----------------------------------------------------------

n.ribC = (n.ribR+n.ribL)/2;

%ËÚä÷êﬂíÜêS à¢ç] (1992) éQè∆----------------------------------------------------------

n.c = (n.c7+n.clav)/2;
                
end

