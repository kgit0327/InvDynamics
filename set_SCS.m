function SCS = set_SCS(n)

%% Definition of the segment coordinate system ---------------------

uarmR = getUarmR(n);
farmR = getFarmR(n);
handR = gethandR(n);
    
uarmL = getUarmL(n);
farmL = getFarmL(n);
handL = gethandL(n);

footR = getfootR(n);
shankR = getshankR(n);
thighR = getthighR(n);
 
footL = getfootL(n);
shankL = getshankL(n);
thighL = getthighL(n);
    
head = gethead(n); 
upt = getuppertorso(n);
lot = getlowertorso(n);

SCS(1) = setSL('hanR',handR);
SCS(2) = setSL('farmR',farmR);
SCS(3) = setSL('uarmR',uarmR);

SCS(4) = setSL('hanL',handL);
SCS(5) = setSL('farmL',farmL);
SCS(6) = setSL('uarmL',uarmL);

SCS(7) = setSL('footR',footR);
SCS(8) = setSL('shankR',shankR);
SCS(9) = setSL('thighR',thighR);

SCS(10) = setSL('footL',footL);
SCS(11) = setSL('shankL',shankL);
SCS(12) = setSL('thighL',thighL);

SCS(13) = setSL('head',head);
SCS(14) = setSL('upt',upt);
SCS(15) = setSL('lot',lot);

end

%% group1 ----------------------------------------------------------        

function handR = gethandR(n) %âEéË

nFr = length(n.handR(1,:));

for iFr = 1:nFr

        zhanR = unitvec(n.wrR(:,iFr)-n.handR(:,iFr));
		shanR = unitvec(n.wrRO(:,iFr)-n.wrRI(:,iFr));
		yhanR = unitvec(cross(zhanR,shanR));
		xhanR = unitvec(cross(yhanR,zhanR));

	   R = [xhanR yhanR zhanR];
       Var(iFr).R = R;
       
end

	handR.Var = Var; 
        
end

function farmR = getFarmR(n) %âEëOòr

nFr = length(n.handR(1,:));

for iFr = 1:nFr

        zfarmR = unitvec(n.elbR(:,iFr)-n.wrR(:,iFr));
		sfarmR = unitvec(n.wrRO(:,iFr)-n.wrRI(:,iFr));
		yfarmR = unitvec(cross(zfarmR,sfarmR));
		xfarmR = unitvec(cross(yfarmR,zfarmR));

		R = [xfarmR yfarmR zfarmR];
        Var(iFr).R = R;
        
end

	farmR.Var = Var; 
    
end

function uarmR = getUarmR(n) %âEè„òr
 
 nFr = length(n.handR(1,:));
 
for iFr=1:nFr

        zuarmR = unitvec(n.shR(:,iFr)-n.elbR(:,iFr));
		suarmR = unitvec(n.elbRO(:,iFr)-n.elbRI(:,iFr));
		yuarmR = unitvec(cross(zuarmR,suarmR));
        xuarmR = unitvec(cross(yuarmR,zuarmR));

        R = [xuarmR yuarmR zuarmR];
        Var(iFr).R = R;
        
end

	    uarmR.Var = Var; 
        
end   

%% group2 ----------------------------------------------------------        

function hanL = gethandL(n) %ç∂éË
 
 nFr = length(n.handR(1,:));
 
for iFr = 1:nFr

        zhanL = unitvec(n.wrL(:,iFr)-n.handL(:,iFr));
		shanL = unitvec(n.wrLI(:,iFr)-n.wrLO(:,iFr));
		yhanL = unitvec(cross(zhanL,shanL));
		xhanL = unitvec(cross(yhanL,zhanL));

		R = [xhanL yhanL zhanL];
        Var(iFr).R = R;
        
end

	hanL.Var = Var;
    
end   
 
function farmL = getFarmL(n) %ç∂ëOòr

 nFr = length(n.handR(1,:));
 
for iFr = 1:nFr

        zfarmL = unitvec(n.elbL(:,iFr)-n.wrL(:,iFr));
		sfarmL = unitvec(n.wrLI(:,iFr)-n.wrLO(:,iFr));
		yfarmL = unitvec(cross(zfarmL,sfarmL));
		xfarmL = unitvec(cross(yfarmL,zfarmL));

		R = [xfarmL yfarmL zfarmL];
        Var(iFr).R = R;
        
end

	farmL.Var = Var;
    
end

function uarmL = getUarmL(n) %ç∂è„òr

   nFr = length(n.handL(1,:));
   
for iFr = 1:nFr

        zuarmL = unitvec(n.shL(:,iFr)-n.elbL(:,iFr));
		suarmL = unitvec(n.elbLI(:,iFr)-n.elbLO(:,iFr));
		yuarmL = unitvec(cross(zuarmL,suarmL));
        xuarmL = unitvec(cross(yuarmL,zuarmL));

        R = [xuarmL yuarmL zuarmL];
        Var(iFr).R = R;
        
end

	uarmL.Var = Var;
    
end 

%% group3 ----------------------------------------------------------   

function footR = getfootR(n) %âEë´
	
  nFr = length(n.handR(1,:));
  
for iFr = 1:nFr

		zfootR = unitvec(n.heelR(:,iFr)-n.baR(:,iFr));
		sfootR = unitvec(n.baRO(:,iFr)-n.baRI(:,iFr));
        yfootR = unitvec(cross(zfootR,sfootR));
		xfootR = unitvec(cross(yfootR,zfootR));

		R = [xfootR yfootR zfootR];
        Var(iFr).R = R;
        
end

	footR.Var = Var; 
    
end

function shankR = getshankR(n) %âEâ∫ë⁄

  nFr = length(n.handR(1,:));
  
for iFr = 1:nFr

		sshankR = unitvec(n.anRO(:,iFr)-n.anRI(:,iFr));
		zshankR = unitvec(n.knR(:,iFr)-n.anR(:,iFr));
		yshankR = unitvec(cross(zshankR,sshankR));
		xshankR = unitvec(cross(yshankR,zshankR));

		R = [xshankR yshankR zshankR];
        Var(iFr).R = R;
        
end

	shankR.Var = Var; 
    
end

function thighR = getthighR(n) %âEëÂë⁄

  nFr = length(n.handR(1,:));

for iFr = 1:nFr

		zthighR = unitvec(n.hipR(:,iFr)-n.knR(:,iFr));
		sthighR = unitvec(n.knRO(:,iFr)-n.knRI(:,iFr));
		ythighR = unitvec(cross(zthighR,sthighR));
        xthighR = unitvec(cross(ythighR,zthighR));

		R = [xthighR ythighR zthighR];
		Var(iFr).R = R;
        
end

	thighR.Var = Var;
    
end

%% group4 ----------------------------------------------------------

function footL = getfootL(n) %ç∂ë´

 nFr = length(n.handR(1,:));
 
for iFr = 1:nFr
    
		zfootL = unitvec(n.heelL(:,iFr)-n.baL(:,iFr));
		sfootL = unitvec(n.baLI(:,iFr)-n.baLO(:,iFr));
        yfootL = unitvec(cross(zfootL,sfootL));
		xfootL = unitvec(cross(yfootL,zfootL));

		R = [xfootL yfootL zfootL];
        Var(iFr).R = R;
        
end

	footL.Var = Var;
    
end

function shankL = getshankL(n) %ç∂â∫ë⁄
        
    nFr = length(n.handR(1,:));
    
for iFr = 1:nFr

		sshankL = unitvec(n.anLI(:,iFr)-n.anLO(:,iFr));
		zshankL = unitvec(n.knL(:,iFr)-n.anL(:,iFr));
		yshankL = unitvec(cross(zshankL,sshankL));
		xshankL = unitvec(cross(yshankL,zshankL));

		R = [xshankL yshankL zshankL];
        Var(iFr).R = R;
        
end

	shankL.Var = Var;
    
end

function thighL = getthighL(n) %ç∂ëÂë⁄

  nFr = length(n.handR(1,:));
  
for iFr = 1:nFr

		zthighL = unitvec(n.hipL(:,iFr)-n.knL(:,iFr));
		sthighL = unitvec(n.knLI(:,iFr)-n.knLO(:,iFr));
		ythighL = unitvec(cross(zthighL,sthighL));
        xthighL = unitvec(cross(ythighL,zthighL));

		R = [xthighL ythighL zthighL];
        Var(iFr).R = R;
        
end

	thighL.Var = Var;
    
end

%% group5 ----------------------------------------------------------        

function head = gethead(n) %ì™ïî

 nFr = length(n.handR(1,:));

for iFr = 1:nFr
    
        zhead = unitvec(n.head(:,iFr)-n.c(:,iFr));
		shead = unitvec(n.earR(:,iFr)-n.earL(:,iFr));
		yhead = unitvec(cross(zhead,shead));
		xhead = unitvec(cross(yhead,zhead));

		R = [xhead yhead zhead];
        Var(iFr).R = R;
        
end

	head.Var = Var; 
    
end

function upt = getuppertorso(n) %è„ì∑

nFr = length(n.handR(1,:));

for iFr = 1:nFr
    
        zupt = unitvec(n.c(:,iFr)-n.ribC(:,iFr));
        supt = unitvec(n.clav(:,iFr)-n.c7(:,iFr));
        xupt = unitvec(cross(supt,zupt));
        yupt = unitvec(cross(zupt,xupt));
        
        R = [xupt yupt zupt];
        Var(iFr).R = R;
end

    upt.Var = Var;
    
end

function lot = getlowertorso(n) %â∫ì∑

  nFr = length(n.handR(1,:));
  
for iFr=1:nFr

       xlot = unitvec(n.ASISR(:,iFr)-n.ASISL(:,iFr));
	   slot = unitvec(n.ASISC(:,iFr)-n.PSISC(:,iFr));
	   zlot = unitvec(cross(xlot,slot));
	   ylot = unitvec(cross(zlot,xlot));

	   R = [xlot ylot zlot];
       Var(iFr).R = R;

end

	lot.Var = Var;
    
end

%% -----------------------------------------------------------------        

function SCS = setSL(name,sSCS)

SCS.segname = name;
SCS.Var = sSCS.Var;

end