function Unit = set_JCS_JA(nFr,SCS)

%Definition of the joint coordinate system to calculate the joint angle.

%Grood, E. S., & Suntay, W. J.(1983) method
%ISB recommendation, J Biomech, (2002)

%Unit(iGrp).JCS(iJnt).Var(iFr).R    : JCS unit vector matrix (=transformation matrix)
%Unit(iGrp).JA                      :Joint Angle
%Unit(iGrp).JV                      :Joint Angular velocity

%	Grp1:Rarm 	Grp2:Larm 	Grp3:Rleg 	Grp4:Lleg 	Grp5:Head & Trunk
%   iJnt1: hip, sholder, or neck
%   iJnt2: knee, elbow, or lumbosacraljoint
%   iJnt3: ankle or wrist

Grp = 1;
Unit(Grp) = setRarm(nFr,SCS);

Grp = 2;
Unit(Grp) = setLarm(nFr,SCS);

Grp = 3;
Unit(Grp) = setRleg(nFr,SCS);

Grp = 4;
Unit(Grp) = setLleg(nFr,SCS);

Grp = 5;
Unit(Grp) = setTrunk(nFr,SCS);

end

function Unit = setRarm(nFr,SCS)


for iFr = 1:nFr

%--------CS.upt-------- 
xupt = SCS(14).Var(iFr).R(:,1);
yupt = SCS(14).Var(iFr).R(:,2);
zupt = SCS(14).Var(iFr).R(:,3); 

%--------CS.uarmR--------  
xuarmR = SCS(3).Var(iFr).R(:,1);
yuarmR = SCS(3).Var(iFr).R(:,2);
zuarmR = SCS(3).Var(iFr).R(:,3); 
               
%--------CS.farm--------        
xfarmR = SCS(2).Var(iFr).R(:,1);
yfarmR = SCS(2).Var(iFr).R(:,2);
zfarmR = SCS(2).Var(iFr).R(:,3); 
               
%--------CS.hanR--------        
xhanR = SCS(1).Var(iFr).R(:,1);
yhanR = SCS(1).Var(iFr).R(:,2);
zhanR = SCS(1).Var(iFr).R(:,3); 
        
%------------------------ 
%JCS unit vector matrix
%------------------------ 
       
%-------JCS.shR------
zshR = zuarmR;
xshR = xupt;
yshR = unitvec(cross(zshR,xshR));
      
Unit.JCS(1).Var(iFr).R = [xshR yshR zshR];
       
cs.FshR = [xshR yshR cross(xshR,yshR)];

%-------JCS.elbR------
zelbR = zfarmR;
xelbR = xuarmR;
yelbR = unitvec(cross(zelbR,xelbR)); 
        
Unit.JCS(2).Var(iFr).R = [xelbR yelbR zelbR];

cs.FelbR = [xelbR yelbR cross(xelbR,yelbR)];
        
%-------JCS.wrR------
zwrR = zhanR;
xwrR = xfarmR;
ywrR = unitvec(cross(zwrR,xwrR));
       
Unit.JCS(3).Var(iFr).R = [xwrR ywrR zwrR];

cs.FwrR = [xwrR ywrR cross(xwrR,ywrR)];

%------------------------ 
%Joint angle
%------------------------

%---JA.sFE--- +Flex / -Ex
tmp = (SCS(14).Var(iFr).R)\unitvec(cross(zshR,xshR));
JAtmp.sFE(iFr) = atan2(tmp(3),tmp(2));
JAtmp.sFE = modifyJA(JAtmp.sFE);

%---JA.sAA--- +AB / -AD
tmp = (cs.FshR)\unitvec(zshR);
JAtmp.sAA(iFr) = -atan2(tmp(1),tmp(3));
JAtmp.sAA = modifyJA(JAtmp.sAA);

%---JA.sIER--- +ER / -IR
tmp = (SCS(3).Var(iFr).R)\unitvec(cross(yshR,zshR));
JAtmp.sIER(iFr) = atan2(tmp(2),tmp(1));
JAtmp.sIER = modifyJA(JAtmp.sIER);

%---JA.eFE--- +Flex / -Ex     
tmp = (SCS(3).Var(iFr).R)\unitvec(cross(zelbR,xelbR));
JAtmp.eFE(iFr) = atan2(tmp(3),tmp(2));
JAtmp.eEF = modifyJA(JAtmp.eFE);
        
%---JA.eAA--- +AB / -AD
tmp = (cs.FelbR)\unitvec(zelbR);
JAtmp.eAA(iFr) = -atan2(tmp(1),tmp(3));
JAtmp.eAA = modifyJA(JAtmp.eAA);

%---JA.eIER--- +ER / -IR
tmp = (SCS(2).Var(iFr).R)\unitvec(cross(yelbR,zelbR));
JAtmp.eIER(iFr) = atan2(tmp(2),tmp(1));
JAtmp.eIER = modifyJA(JAtmp.eIER);
        
%---JA.wPDF--- +PF / -DF
tmp = (SCS(2).Var(iFr).R)\unitvec(zwrR);
JAtmp.wPDF(iFr) = -atan2(tmp(3),tmp(2));
JAtmp.wPDF = modifyJA(JAtmp.wPDF);

%---JA.wRU--- +AB / -AD
tmp = (cs.FwrR)\unitvec(zwrR);
JAtmp.wRU(iFr) = atan2(tmp(1),tmp(3));
JAtmp.wRU = modifyJA(JAtmp.wRU);

%---JA.wIER---
JAtmp.wIER(iFr) = 0;


Unit.JA = [JAtmp.sFE...
          ;JAtmp.sAA...
          ;JAtmp.sIER...
          ;JAtmp.eFE...
          ;JAtmp.eAA...
          ;JAtmp.eIER...
          ;JAtmp.wPDF...
          ;JAtmp.wRU...
          ;JAtmp.wIER];
    
end

end

function Unit = setLarm(nFr,SCS)

for iFr = 1:nFr

%--------CS.upt------- 
xupt = SCS(14).Var(iFr).R(:,1);
yupt = SCS(14).Var(iFr).R(:,2);
zupt = SCS(14).Var(iFr).R(:,3); 

%--------CS.uarm--------        
xuarmL = SCS(6).Var(iFr).R(:,1);
yuarmL = SCS(6).Var(iFr).R(:,2);
zuarmL = SCS(6).Var(iFr).R(:,3);
        
%--------CS.farm--------        
xfarmL = SCS(5).Var(iFr).R(:,1);
yfarmL = SCS(5).Var(iFr).R(:,2);
zfarmL = SCS(5).Var(iFr).R(:,3);
                
%--------CS.hanL--------        
xhanL = SCS(4).Var(iFr).R(:,1);
yhanL = SCS(4).Var(iFr).R(:,2);
zhanL = SCS(4).Var(iFr).R(:,3);

%------------------------ 
%JCS unit vector matrix
%------------------------ 
       
%-------JCS.shL------
zshL = zuarmL;
xshL = xupt;
yshL = unitvec(cross(zshL,xshL)); 
        
Unit.JCS(1).Var(iFr).R = [xshL yshL zshL];

cs.FshL = [xshL yshL cross(xshL,yshL)];
        
%-------JCS.elbL------
zelbL = zfarmL;
xelbL = xuarmL;
yelbL = unitvec(cross(zelbL,xelbL));
        
Unit.JCS(2).Var(iFr).R = [xelbL yelbL zelbL];

cs.FelbL = [xelbL yelbL cross(xelbL,yelbL)];
        
%-------JCS.wrL------
zwrL = zhanL;
xwrL = xfarmL;
ywrL = unitvec(cross(zwrL,xwrL));
  
Unit.JCS(3).Var(iFr).R = [xwrL ywrL zwrL];

cs.FwrL = [xwrL ywrL cross(xwrL,ywrL)];

%------------------------ 
%Joint angle
%------------------------

%---JA.sFE--- +Flex / -Ex
tmp = (SCS(14).Var(iFr).R)\unitvec(cross(zshL,xshL));
JAtmp.sFE(iFr) = atan2(tmp(3),tmp(2));
JAtmp.sFE = modifyJA(JAtmp.sFE);

%---JA.sAA--- +AB / -AD
tmp = (cs.FshL)\unitvec(zshL);
JAtmp.sAA(iFr) = atan2(tmp(1),tmp(3));
JAtmp.sAA = modifyJA(JAtmp.sAA);

%---JA.sIER--- +ER / -IR
tmp = (SCS(6).Var(iFr).R)\unitvec(cross(yshL,zshL));
JAtmp.sIER(iFr) = -atan2(tmp(2),tmp(1));
JAtmp.sIER = modifyJA(JAtmp.sIER);

%---JA.eFE--- +Flex / -Ex
tmp =(SCS(6).Var(iFr).R)\unitvec(cross(zelbL,xelbL));
JAtmp.eFE(iFr) = atan2(tmp(3),tmp(2));
JAtmp.eFE = modifyJA(JAtmp.eFE);

%---JA.eAA--- +AB / -AD
tmp = (cs.FelbL)\unitvec(zelbL);
JAtmp.eAA(iFr) = atan2(tmp(1),tmp(3));
JAtmp.eAA = modifyJA(JAtmp.eAA);

%---JA.eIER--- +ER / -IR
tmp = (SCS(5).Var(iFr).R)\unitvec(cross(yelbL,zelbL));
JAtmp.eIER(iFr) = -atan2(tmp(2),tmp(1));
JAtmp.eIER = modifyJA(JAtmp.eIER);

%---JA.wPDF--- +PF / -DF
tmp = (SCS(5).Var(iFr).R)\unitvec(cross(zwrL,xwrL));
JAtmp.wPDF(iFr) = atan2(tmp(3),tmp(2));
JAtmp.wPDF = modifyJA(JAtmp.wPDF);

%---JA.wRU--- +AB / -AD
tmp = (cs.FwrL)\unitvec(zwrL);
JAtmp.wRU(iFr) = atan2(tmp(1),tmp(3));
JAtmp.wRU = modifyJA(JAtmp.wRU);

%---JA.wIER---
JAtmp.wIER(iFr) = 0;


Unit.JA = [JAtmp.sFE...
          ;JAtmp.sAA...
          ;JAtmp.sIER...
          ;JAtmp.eFE...
          ;JAtmp.eAA...
          ;JAtmp.eIER...
          ;JAtmp.wPDF...
          ;JAtmp.wRU...
          ;JAtmp.wIER];
                
end

end

function Unit = setRleg(nFr,SCS)

for iFr = 1:nFr

% ---- CS.lot----
xlot = SCS(15).Var(iFr).R(:,1);
ylot = SCS(15).Var(iFr).R(:,2);
zlot = SCS(15).Var(iFr).R(:,3);

% ---- CS.thighR----
xthighR = SCS(9).Var(iFr).R(:,1);
ythighR = SCS(9).Var(iFr).R(:,2);
zthighR = SCS(9).Var(iFr).R(:,3);
        
% ---- CS.shankR----
xshankR = SCS(8).Var(iFr).R(:,1);
yshankR = SCS(8).Var(iFr).R(:,2);
zshankR = SCS(8).Var(iFr).R(:,3);

% ---- CS.footR----
xfootR = SCS(7).Var(iFr).R(:,1);
yfootR = SCS(7).Var(iFr).R(:,2);
zfootR = SCS(7).Var(iFr).R(:,3);

%------------------------ 
%JCS unit vector matrix
%------------------------ 
        
%-------JCS.hipR------
zhipR = zthighR;
xhipR = xlot;
yhipR = unitvec(cross(zhipR,xhipR));
        
Unit.JCS(1).Var(iFr).R = [xhipR yhipR zhipR];

cs.FhipR = [xhipR yhipR cross(xhipR,yhipR)];

%-------JCS.kneeR------
zkneeR = zshankR;
xkneeR = xthighR;
ykneeR = unitvec(cross(zkneeR,xkneeR));
        
Unit.JCS(2).Var(iFr).R = [xkneeR ykneeR zkneeR];

cs.FkneeR = [xkneeR ykneeR cross(xkneeR,ykneeR)];
        
%-------JCS.ankleR------
zankleR = zfootR;
xankleR = xshankR;
yankleR = unitvec(cross(zankleR,xankleR));
        
Unit.JCS(3).Var(iFr).R = [xankleR yankleR zankleR];

cs.FankleR = [xankleR yankleR cross(xankleR,yankleR)];

%------------------------ 
%Joint angle
%------------------------

%---JA.hFE--- +Ex / -Flex
tmp = (SCS(15).Var(iFr).R)\unitvec(cross(zhipR,xhipR));
JAtmp.hFE(iFr) = -atan2(tmp(3),tmp(2));
JAtmp.hFE = modifyJA(JAtmp.hFE);
        
%---JA.hAA--- +AB / -AD
tmp = (cs.FhipR)\unitvec(zhipR);
JAtmp.hAA(iFr) = -atan2(tmp(1),tmp(3));
JAtmp.hAA = modifyJA(JAtmp.hAA);
        
%---JA.hIER--- +ER / -IR
tmp = (SCS(9).Var(iFr).R)\unitvec(cross(yhipR,zhipR));
JAtmp.hIER(iFr) = atan2(tmp(2),tmp(1));
JAtmp.hIER = modifyJA(JAtmp.hIER);
        
%---JA.kFE--- +Ex / -Flex
tmp = (SCS(9).Var(iFr).R)\unitvec(cross(zkneeR,xkneeR));
JAtmp.kFE(iFr) = atan2(tmp(3),tmp(2));
JAtmp.kFE = modifyJA(JAtmp.kFE);
        
%---JA.kAA--- +var / -val
tmp = (cs.FkneeR)\unitvec(zkneeR);
JAtmp.kAA(iFr) = -atan2(tmp(1),tmp(3));
JAtmp.kAA = modifyJA(JAtmp.kAA);
        
%---JA.kIER--- +ER / -IR
tmp = (SCS(8).Var(iFr).R)\unitvec(cross(ykneeR,zkneeR));
JAtmp.kIER(iFr) = atan2(tmp(2),tmp(1));
JAtmp.kIER = modifyJA(JAtmp.kIER);
        
%---JA.aPDF--- +Ex / -Flex
tmp = (SCS(8).Var(iFr).R)\unitvec(cross(zankleR,xankleR));
JAtmp.aPDF(iFr) = -atan2(tmp(3),tmp(2));
JAtmp.aPDF = modifyJA(JAtmp.aPDF);
             
%---JA.aAA--- +AB / -AD
tmp = (cs.FankleR)\unitvec(zankleR);
JAtmp.aAA(iFr) = -atan2(tmp(1),tmp(3));
JAtmp.aAA = modifyJA(JAtmp.aAA);
       
%---JA.aIER--- +ER / -IR
tmp = (SCS(7).Var(iFr).R)\unitvec(cross(yankleR,zankleR));
JAtmp.aIER(iFr) = atan2(tmp(2),tmp(1));
JAtmp.aIER = modifyJA(JAtmp.aIER);
                   
               
Unit.JA = [JAtmp.hFE...
          ;JAtmp.hAA...
          ;JAtmp.hIER...
          ;JAtmp.kFE...
          ;JAtmp.kAA...
          ;JAtmp.kIER...
          ;JAtmp.aPDF...
          ;JAtmp.aAA...
          ;JAtmp.aIER];
                
end
     
end
 
function Unit = setLleg(nFr,SCS)

for iFr = 1:nFr

% ---- CS.lot----
xlot = SCS(15).Var(iFr).R(:,1);
ylot = SCS(15).Var(iFr).R(:,2);
zlot = SCS(15).Var(iFr).R(:,3);
        
% ---- CS.thighL----
xthighL = SCS(12).Var(iFr).R(:,1);
ythighL = SCS(12).Var(iFr).R(:,2);
zthighL = SCS(12).Var(iFr).R(:,3);
        
% ---- CS.shankL----
xshankL = SCS(11).Var(iFr).R(:,1);
yshankL = SCS(11).Var(iFr).R(:,2);
zshankL = SCS(11).Var(iFr).R(:,3);

% ---- CS.footL----
xfootL = SCS(10).Var(iFr).R(:,1);
yfootL = SCS(10).Var(iFr).R(:,2);
zfootL = SCS(10).Var(iFr).R(:,3);

%------------------------ 
%JCS unit vector matrix
%------------------------ 

%-------CS.hipL------
zhipL = zthighL;
xhipL = xlot;
yhipL = unitvec(cross(zhipL,xhipL));
        
Unit.JCS(1).Var(iFr).R = [xhipL yhipL zhipL];

cs.FhipL = [xhipL yhipL cross(xhipL,yhipL)];
        
%-------CS.kneeL------
zkneeL = zshankL;
xkneeL = xthighL;
ykneeL = unitvec(cross(zkneeL,xkneeL));
        
Unit.JCS(2).Var(iFr).R = [xkneeL ykneeL zkneeL];

cs.FkneeL = [xkneeL ykneeL cross(xkneeL,ykneeL)];

%-------CS.ankleL------
zankleL = zfootL;
xankleL = xshankL;
yankleL = unitvec(cross(zankleL,xankleL));
        
Unit.JCS(3).Var(iFr).R = [xankleL yankleL zankleL];

cs.FankleL = [xankleL yankleL cross(xankleL,yankleL)];

%------------------------ 
%Joint angle
%------------------------

%---JA.hFE--- +Ex / -Flex
tmp = (SCS(15).Var(iFr).R)\unitvec(cross(zhipL,xhipL));
JAtmp.hFE(iFr) = -atan2(tmp(3),tmp(2));
JAtmp.hFE = modifyJA(JAtmp.hFE);
        
%---JA.hAA--- +AB / -AD
tmp = (cs.FhipL)\unitvec(zhipL);
JAtmp.hAA(iFr) = atan2(tmp(1),tmp(3));
JAtmp.hAA = modifyJA(JAtmp.hAA);
        
%---JA.hIER--- +ER / -IR
tmp = (SCS(12).Var(iFr).R)\unitvec(cross(yhipL,zhipL));
JAtmp.hIER(iFr) = -atan2(tmp(2),tmp(1));
JAtmp.hIER = modifyJA(JAtmp.hIER);
        
%---JA.kFE--- +Ex / -Flex
tmp = (SCS(12).Var(iFr).R)\unitvec(cross(zkneeL,xkneeL));
JAtmp.kFE(iFr) = atan2(tmp(3),tmp(2));
JAtmp.kFE = modifyJA(JAtmp.kFE);
        
%---JA.kAA--- +var / -val
tmp = (cs.FkneeL)\unitvec(zkneeL);
JAtmp.kAA(iFr) = atan2(tmp(1),tmp(3));
JAtmp.kAA = modifyJA(JAtmp.kAA);
        
%---JA.kIER--- +ER / -IR
tmp = (SCS(11).Var(iFr).R)\unitvec(cross(ykneeL,zkneeL));
JAtmp.kIER(iFr) = -atan2(tmp(2),tmp(1));
JAtmp.kIER = modifyJA(JAtmp.kIER);
        
%---JA.aPDF--- +Ex / -Flex
tmp = (SCS(11).Var(iFr).R)\unitvec(cross(zankleL,xankleL));
JAtmp.aPDF(iFr) = -atan2(tmp(3),tmp(2));
JAtmp.aPDF = modifyJA(JAtmp.aPDF);
               
%---JA.aAA--- +AB / -AD
tmp = (cs.FankleL)\unitvec(zankleL);
JAtmp.aAA(iFr) = atan2(tmp(1),tmp(3));
JAtmp.aAA = modifyJA(JAtmp.aAA);
        
%---JA.aIER--- +ER / -IR
tmp = (SCS(10).Var(iFr).R)\unitvec(cross(yankleL,zankleL));
JAtmp.aIER(iFr) = -atan2(tmp(2),tmp(1));
JAtmp.aIER = modifyJA(JAtmp.aIER);
            
    
Unit.JA = [JAtmp.hFE...
          ;JAtmp.hAA...
          ;JAtmp.hIER...
          ;JAtmp.kFE...
          ;JAtmp.kAA...
          ;JAtmp.kIER...
          ;JAtmp.aPDF...
          ;JAtmp.aAA...
          ;JAtmp.aIER];

end

end

function Unit = setTrunk(nFr,SCS)

for iFr = 1:nFr
    
% ---- CS.head----
xhead = SCS(13).Var(iFr).R(:,1);
yhead = SCS(13).Var(iFr).R(:,2);
zhead = SCS(13).Var(iFr).R(:,3);

% ---- CS.upt----
xupt = SCS(14).Var(iFr).R(:,1);
yupt = SCS(14).Var(iFr).R(:,2);
zupt = SCS(14).Var(iFr).R(:,3); 
    
% ---- CS.lot----
xlot = SCS(15).Var(iFr).R(:,1);
ylot = SCS(15).Var(iFr).R(:,2);
zlot = SCS(15).Var(iFr).R(:,3);
    
%------------------------ 
%JCS unit vector matrix
%------------------------ 

%-------JCS.neck------
zneck = unitvec(zhead);
xneck = unitvec(xupt);
yneck = unitvec(cross(zneck,xneck));

Unit.JCS(1).Var(iFr).R = [xneck yneck zneck];

cs.Fneck = [xneck yneck cross(xneck,yneck)];

%-------CS.ribC------
zribC = unitvec(zupt);
xribC = unitvec(xlot);
yribC = unitvec(cross(zribC,xribC));

Unit.JCS(2).Var(iFr).R = [xribC yribC zribC];

cs.FribC = [xribC yribC cross(xribC,yribC)];

%------------------------ 
%Joint angle
%------------------------

%---JA.neAPF--- +Ex / -Flex
tmp = (SCS(14).Var(iFr).R)\unitvec(cross(zneck,xneck));
JAtmp.neAPF(iFr) = atan2(tmp(3),tmp(2));

%---JAtmp.neLMF--- +Right / -Left
tmp = (cs.Fneck)\unitvec(zneck);
JAtmp.neLMF(iFr) = atan2(tmp(1),tmp(3));
        
%---JAtmp.neRot---  +Right rot / -Left rot 
tmp = (SCS(13).Var(iFr).R)\unitvec(cross(yneck,zneck));
JAtmp.neRot(iFr) = -atan2(tmp(2),tmp(1));

%---JAtmp.luFE--- +Ex / -Flex
tmp = (SCS(15).Var(iFr).R)\unitvec(cross(zribC,xribC));
JAtmp.luFE(iFr) = atan2(tmp(3),tmp(2));

%---JAtmp.luED--- +Right up / -Left up (‰º“·‚ª)
tmp = (cs.FribC)\unitvec(zribC);
JAtmp.luED(iFr) = atan2(tmp(1),tmp(3));
        
%---JAtmp.luRot--- +Right rot / -Left rot (‰º“·‚ª)
tmp = (SCS(14).Var(iFr).R)\unitvec(cross(yribC,zribC));
JAtmp.luRot(iFr) = -atan2(tmp(2),tmp(1));

    
Unit.JA = [JAtmp.neAPF...
          ;JAtmp.neLMF...
          ;JAtmp.neRot...
          ;JAtmp.luFE...
          ;JAtmp.luED...
          ;JAtmp.luRot];

end

end
