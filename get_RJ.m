function  RJ = get_RJ(SCS,nFr)

shRR = getshRR(SCS,nFr);
elbRR = getelbRR(SCS,nFr);
wrRR = getwrRR(SCS,nFr);

shLR = getshLR(SCS,nFr);
elbLR = getelbLR(SCS,nFr);
wrLR = getwrLR(SCS,nFr);
	
hipRR = gethipRR(SCS,nFr);
knRR = getknRR(SCS,nFr);
ankRR = getankRR(SCS,nFr);
    
hipLR = gethipLR(SCS,nFr);
knLR = getknLR(SCS,nFr);
ankLR = getankLR(SCS,nFr); 
   
neckR = getneckR(SCS,nFr);
ribCR = getribCR(SCS,nFr);
    
RJ(1) = setSLRJ('shR',shRR);
RJ(2) = setSLRJ('elbR',elbRR);
RJ(3) = setSLRJ('wrR',wrRR);
RJ(4) = setSLRJ('shL',shLR);
RJ(5) = setSLRJ('elbL',elbLR);
RJ(6) = setSLRJ('wrL',wrLR);
RJ(7) = setSLRJ('hipR',hipRR);
RJ(8) = setSLRJ('knR',knRR);
RJ(9) = setSLRJ('ankR',ankRR);
RJ(10) = setSLRJ('hipL',hipLR);
RJ(11) = setSLRJ('knL',knLR);
RJ(12) = setSLRJ('ankL',ankLR);
RJ(13) = setSLRJ('neck',neckR);
RJ(14) = setSLRJ('ribC',ribCR);

end

function shRR = getshRR(SCS,nFr)

 RJ = zeros(3,3*nFr)';

for iFr = 1:nFr
   
    RJ((3*(iFr-1)+1:3*iFr),:) = SCS(3).Var(iFr).R\SCS(14).Var(iFr).R;
    
end

    shRR.mat = RJ;

end

function elbRR = getelbRR(SCS,nFr)

    RJ = zeros(3,3*nFr)';
    
for iFr = 1:nFr
    
    RJ((3*(iFr-1)+1:3*iFr),:) = SCS(2).Var(iFr).R\SCS(3).Var(iFr).R;
    
end

    elbRR.mat = RJ;
    
end


function wrRR = getwrRR(SCS,nFr)

 RJ = zeros(3,3*nFr)';

for iFr = 1:nFr
    
    RJ((3*(iFr-1)+1:3*iFr),:) = SCS(1).Var(iFr).R\SCS(2).Var(iFr).R;
    
end

    wrRR.mat=RJ;

end

function shLR = getshLR(SCS,nFr)

  RJ = zeros(3,3*nFr)';

for iFr = 1:nFr
    
    RJ((3*(iFr-1)+1:3*iFr),:) = SCS(6).Var(iFr).R\SCS(14).Var(iFr).R;
    
end

    shLR.mat=RJ;

end

function elbLR = getelbLR(SCS,nFr)
  
    RJ = zeros(3,3*nFr)';

for iFr = 1:nFr
    
    RJ((3*(iFr-1)+1:3*iFr),:) = SCS(5).Var(iFr).R\SCS(6).Var(iFr).R;
    
end

    elbLR.mat = RJ;

end

function wrLR = getwrLR(SCS,nFr)

    RJ = zeros(3,3*nFr)';

for iFr = 1:nFr
 
    RJ((3*(iFr-1)+1:3*iFr),:) = SCS(4).Var(iFr).R\SCS(5).Var(iFr).R;
    
end

    wrLR.mat=RJ;

end

function hipRR = gethipRR(SCS,nFr)

    RJ = zeros(3,3*nFr)';

for iFr = 1:nFr
    
    RJ((3*(iFr-1)+1:3*iFr),:) = SCS(9).Var(iFr).R\SCS(15).Var(iFr).R;
    
end

    hipRR.mat=RJ;

end

function knRR = getknRR(SCS,nFr)

    RJ = zeros(3,3*nFr)';

for iFr = 1:nFr
    
    RJ((3*(iFr-1)+1:3*iFr),:) = SCS(8).Var(iFr).R\SCS(9).Var(iFr).R;
    
end

    knRR.mat = RJ;

end

function ankRR = getankRR(SCS,nFr)

    RJ = zeros(3,3*nFr)';

for iFr = 1:nFr
    
    RJ((3*(iFr-1)+1:3*iFr),:) = SCS(7).Var(iFr).R\SCS(8).Var(iFr).R;
    
end

    ankRR.mat = RJ;

end

function hipLR = gethipLR(SCS,nFr)

    RJ = zeros(3,3*nFr)';

for iFr = 1:nFr

    RJ((3*(iFr-1)+1:3*iFr),:) = SCS(12).Var(iFr).R\SCS(15).Var(iFr).R;
    
end

    hipLR.mat = RJ;

end

function knLR = getknLR(SCS,nFr)

    RJ = zeros(3,3*nFr)';

for iFr = 1:nFr
    
    RJ((3*(iFr-1)+1:3*iFr),:) = SCS(11).Var(iFr).R\SCS(12).Var(iFr).R;
    
end

    knLR.mat = RJ;

end

function ankLR = getankLR(SCS,nFr)

    RJ = zeros(3,3*nFr)';

for iFr = 1:nFr
    
    RJ((3*(iFr-1)+1:3*iFr),:) = SCS(10).Var(iFr).R\SCS(11).Var(iFr).R;
    
end

    ankLR.mat = RJ;

end

function neckR = getneckR(SCS,nFr)

    RJ = zeros(3,3*nFr)';

for iFr = 1:nFr
    
    RJ((3*(iFr-1)+1:3*iFr),:) = SCS(13).Var(iFr).R\SCS(14).Var(iFr).R;
    
end

    neckR.mat = RJ;

end

function ribCR = getribCR(SCS,nFr)

    RJ = zeros(3,3*nFr)';

for iFr = 1:nFr
    
    RJ((3*(iFr-1)+1:3*iFr),:) = SCS(14).Var(iFr).R\SCS(15).Var(iFr).R;
    
end

    ribCR.mat = RJ;

end

function RJ = setSLRJ(name,sSCS)

RJ.jntname = name;
RJ.mat = sSCS.mat;

end
