function R=get_R(SCS,nFr) %1Ç¬ÇÃÉZÉãÇ…äiî[Ç≥ÇÍÇƒÇ¢ÇΩà⁄ìÆç¿ïWånÇ3çs3óÒÇÃçsóÒÇ…ï™â

uarmRR = getUarmRR(SCS,nFr);
farmRR = getFarmRR(SCS,nFr);
handRR = gethandRR(SCS,nFr);
    
uarmLR = getUarmLR(SCS,nFr);
farmLR = getFarmLR(SCS,nFr);
handLR = gethandLR(SCS,nFr);

footRR = getfootRR(SCS,nFr);
shankRR = getshankRR(SCS,nFr);
thighRR = getthighRR(SCS,nFr);
 
footLR = getfootLR(SCS,nFr);
shankLR = getshankLR(SCS,nFr);
thighLR = getthighLR(SCS,nFr);
    
headR = getheadR(SCS,nFr); 
uptR = getuppertorsoR(SCS,nFr);
lotR = getlowertorsoR(SCS,nFr);

R(1) = setSLR('hanR',handRR);
R(2) = setSLR('farmR',farmRR);
R(3) = setSLR('uarmR',uarmRR);

R(4) = setSLR('hanL',handLR);
R(5) = setSLR('farmL',farmLR);
R(6) = setSLR('uarmL',uarmLR);

R(7) = setSLR('footR',footRR);
R(8) = setSLR('shankR',shankRR);
R(9) = setSLR('thighR',thighRR);

R(10) = setSLR('footL',footLR);
R(11) = setSLR('shankL',shankLR);
R(12) = setSLR('thighL',thighLR);

R(13) = setSLR('head',headR);
R(14) = setSLR('upt',uptR);
R(15) = setSLR('mit',lotR);

end

%--------------------------------------------------------------------------  
%--------------------------group1------------------------------------------
%--------------------------------------------------------------------------     


function handRR = gethandRR(SCS,nFr) %âEéË

 R = zeros(3,3*nFr)';

for iFr = 1:nFr
   
    R((3*(iFr-1)+1:3*iFr),:) = SCS(1).Var(iFr).R;
    
end

    handRR.mat = R;

end

function farmRR = getFarmRR(SCS,nFr) %âEëOòr

 R=zeros(3,3*nFr)';
    
for iFr = 1:nFr
    
    R((3*(iFr-1)+1:3*iFr),:) = SCS(2).Var(iFr).R;
    
end

    farmRR.mat = R;
    
end

function uarmRR = getUarmRR(SCS,nFr) %âEè„òr

 R = zeros(3,3*nFr)';

for iFr = 1:nFr
    
    R((3*(iFr-1)+1:3*iFr),:) = SCS(3).Var(iFr).R;

end

    uarmRR.mat = R;
    
end


%--------------------------------------------------------------------------  
%--------------------------group2------------------------------------------
%-------------------------------------------------------------------------- 


function handLR = gethandLR(SCS,nFr) %ç∂éË

 R = zeros(3,3*nFr)';

for iFr = 1:nFr
    
    R((3*(iFr-1)+1:3*iFr),:) = SCS(4).Var(iFr).R;

end
    
    handLR.mat = R;
    
end

function farmLR = getFarmLR(SCS,nFr) %ç∂ëOòr
  
    R = zeros(3,3*nFr)';

for iFr = 1:nFr
    
    R((3*(iFr-1)+1:3*iFr),:) = SCS(5).Var(iFr).R;

end
    
    farmLR.mat = R;
   
end

function uarmLR = getUarmLR(SCS,nFr) %ç∂è„òr

  R = zeros(3,3*nFr)';

for iFr = 1:nFr
    
    R((3*(iFr-1)+1:3*iFr),:) = SCS(6).Var(iFr).R;

end
    
    uarmLR.mat = R;
    
end


%--------------------------------------------------------------------------  
%--------------------------group3------------------------------------------
%--------------------------------------------------------------------------


function footRR = getfootRR(SCS,nFr) %âEë´

  R = zeros(3,3*nFr)';

for iFr = 1:nFr
    
    R((3*(iFr-1)+1:3*iFr),:) = SCS(7).Var(iFr).R;

end
    
    footRR.mat = R;
    
end

function shankRR = getshankRR(SCS,nFr) %âEâ∫ë⁄

   R = zeros(3,3*nFr)';

for iFr = 1:nFr
  
    R((3*(iFr-1)+1:3*iFr),:) = SCS(8).Var(iFr).R;

end

    shankRR.mat = R;
    
end

function thighRR = getthighRR(SCS,nFr) %âEëÂë⁄

   R = zeros(3,3*nFr)';

for iFr = 1:nFr
    
    R((3*(iFr-1)+1:3*iFr),:) = SCS(9).Var(iFr).R;

end
    
    thighRR.mat = R;
    
end


%--------------------------------------------------------------------------  
%--------------------------group4------------------------------------------
%--------------------------------------------------------------------------


function footLR = getfootLR(SCS,nFr)

    R = zeros(3,3*nFr)';

for iFr = 1:nFr

    R((3*(iFr-1)+1:3*iFr),:) = SCS(10).Var(iFr).R;

end

    footLR.mat = R;

end

function shankLR = getshankLR(SCS,nFr)

   R = zeros(3,3*nFr)';

for iFr = 1:nFr
    
    R((3*(iFr-1)+1:3*iFr),:) = SCS(11).Var(iFr).R;

end
    
    shankLR.mat = R;
    
end

function thighLR = getthighLR(SCS,nFr)

  R = zeros(3,3*nFr)';

for iFr = 1:nFr
    
    R((3*(iFr-1)+1:3*iFr),:) = SCS(12).Var(iFr).R;

end

    thighLR.mat = R;
    
end

%--------------------------------------------------------------------------  
%--------------------------group5------------------------------------------
%--------------------------------------------------------------------------


function headR = getheadR(SCS,nFr)

  R = zeros(3,3*nFr)';

for iFr = 1:nFr
    
    R((3*(iFr-1)+1:3*iFr),:) = SCS(13).Var(iFr).R;

end

    headR.mat = R;
    
end

function uptR = getuppertorsoR(SCS,nFr)

 R = zeros(3,3*nFr)';

for iFr = 1:nFr
 
    R((3*(iFr-1)+1:3*iFr),:) = SCS(14).Var(iFr).R;

end

    uptR.mat = R;

end

function lotR = getlowertorsoR(SCS,nFr)

    R = zeros(3,3*nFr)';

for iFr = 1:nFr
    
    R((3*(iFr-1)+1:3*iFr),:) = SCS(15).Var(iFr).R;

end

    lotR.mat = R;

end

%--------------------------------------------------------------------------  
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------


function R = setSLR(name,sSCS)

R.segname = name;
R.mat = sSCS.mat;

end







