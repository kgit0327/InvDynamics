function JAV = get_JAV(segdat,Unit)

[~,nFr] = size(segdat(3).seganV_GCS);

%ŠÖß‚É‘Î‚·‚é‰“ˆÊ‚ÌƒZƒOƒƒ“ƒg‚ğ’è‹`
Dseg(1,1).v = segdat(3).seganV_GCS;  %upper arm(R)
Dseg(1,2).v = segdat(2).seganV_GCS;  %forearm (R)
Dseg(1,3).v = segdat(1).seganV_GCS;  %hand(R)
Dseg(2,1).v = segdat(6).seganV_GCS;  %upper arm(L)
Dseg(2,2).v = segdat(5).seganV_GCS;  %forearm(L)
Dseg(2,3).v = segdat(4).seganV_GCS;  %hand(L)
Dseg(3,1).v = segdat(9).seganV_GCS;  %thighR)
Dseg(3,2).v = segdat(8).seganV_GCS;  %shank(R)
Dseg(3,3).v = segdat(7).seganV_GCS;  %foot(R)
Dseg(4,1).v = segdat(12).seganV_GCS; %thigh(L)
Dseg(4,2).v = segdat(11).seganV_GCS; %shank(L)
Dseg(4,3).v = segdat(10).seganV_GCS; %foot(L)
Dseg(5,1).v = segdat(13).seganV_GCS; %neck
Dseg(5,2).v = segdat(14).seganV_GCS; %upper torso

%ŠÖß‚É‘Î‚·‚é‹ßˆÊ‚ÌƒZƒOƒƒ“ƒg‚ğ’è‹`
Pseg(1,1).v = segdat(14).seganV_GCS; %upper torso 
Pseg(1,2).v = segdat(3).seganV_GCS;  %upper arm (R)
Pseg(1,3).v = segdat(2).seganV_GCS;  %forearm (R)
Pseg(2,1).v = segdat(14).seganV_GCS; %upper torso
Pseg(2,2).v = segdat(6).seganV_GCS;  %upper arm (L)
Pseg(2,3).v = segdat(5).seganV_GCS;  %forearm (L)
Pseg(3,1).v = segdat(15).seganV_GCS; %lower torso
Pseg(3,2).v = segdat(9).seganV_GCS;  %thigh (R)
Pseg(3,3).v = segdat(8).seganV_GCS;  %shank (R)
Pseg(4,1).v = segdat(15).seganV_GCS; %lower torso
Pseg(4,2).v = segdat(12).seganV_GCS; %thigh (L)
Pseg(4,3).v = segdat(11).seganV_GCS; %shank (L)
Pseg(5,1).v = segdat(14).seganV_GCS; %upper torso
Pseg(5,2).v = segdat(15).seganV_GCS; %lower torso
   
for iFr=1:nFr

    for iGrp=1:5
        
        if iGrp == 5
            nJnt = 2;
        else
            nJnt = 3;
        end
                
        for iJnt = 1:nJnt
            
            J(iGrp,iJnt).v(:,iFr) = Dseg(iGrp,iJnt).v(:,iFr)-Pseg(iGrp,iJnt).v(:,iFr);
            Jlocal(iGrp,iJnt).v(:,iFr) = ((Unit(iGrp).JCS(iJnt).Var(iFr).R))\J(iGrp,iJnt).v(:,iFr);
            
        end                                                                                                  
    end
    
end

Jlocal = modifyAxis(Jlocal);
    
JAV = [Jlocal(1,1).v;...     %shR (…•½‹ü‹È+ ŠO“]+ “àù+)
       Jlocal(1,2).v;...     %elbR (L“W+ “à”½+ ‰ñ“à+)
       Jlocal(1,3).v;...     %wrR (¶‹ü + ô‹ü + )
       Jlocal(2,1).v;...     %shL (…•½‹ü‹È+ ŠO“]+ “àù+)
       Jlocal(2,2).v;...     %elbL (L“W+ “à”½+ ‰ñ“à+)
       Jlocal(2,3).v;...     %wrL (¶‹ü + ô‹ü + )
       Jlocal(3,1).v;...     %hipR (‹ü‹È+ ŠO“]+ ŠOù+)
       Jlocal(3,2).v;...     %knR (L“W+ ŠO”½+ “àù+)
       Jlocal(3,3).v;...     %anR( ”w‹ü + “à“]+ ŠOù +)
       Jlocal(4,1).v;...     %hipL (‹ü‹È+ ŠO“]+ ŠOù+)
       Jlocal(4,2).v;...     %knL (L“W+ ŠO”½+ “àù+)
       Jlocal(4,3).v;...     %anL ( ”w‹ü + “à“]+ ŠOù +)
       Jlocal(5,1).v;...     %neck (L“W+ ‰EŒX+ ¶‰ñù+)
       Jlocal(5,2).v;...     %torso (L“W+ ‰EŒX+ ¶‰ñù+)
                    ];
          
function Jlocal = modifyAxis(Jlocal)

%------------------------
%group1
%------------------------

Jlocal(1,1).v(2,:) = -Jlocal(1,1).v(2,:); %shR “à“]+
Jlocal(1,2).v(1,:) = -Jlocal(1,2).v(1,:); %elbR L“W +
Jlocal(1,3).v(2,:) = -Jlocal(1,3).v(2,:); %wrR Ú‹ü +

%------------------------
%group2
%------------------------

Jlocal(2,1).v(2,:) = -Jlocal(2,1).v(2,:); %shL “à“]+
Jlocal(2,1).v(3,:) = -Jlocal(2,1).v(3,:); %shL “àù+
Jlocal(2,2).v(1,:) = -Jlocal(2,2).v(1,:); %elbL L“W +
Jlocal(2,2).v(2,:) = -Jlocal(2,2).v(2,:); %elbL “à”½ +
Jlocal(2,2).v(3,:) = -Jlocal(2,2).v(3,:); %elbL ‰ñ“à +
Jlocal(2,3).v(3,:) = -Jlocal(2,3).v(3,:); %wrL ‰ñ“à +

%------------------------
%group3
%------------------------

 Jlocal(3,1).v(2,:) = -Jlocal(3,1).v(2,:); %hipR ŠO“] +
 Jlocal(3,1).v(3,:) = -Jlocal(3,1).v(3,:); %hipR ŠOù +
 Jlocal(3,2).v(2,:) = -Jlocal(3,2).v(2,:); %knR ŠO”½ +
 Jlocal(3,2).v(3,:) = -Jlocal(3,2).v(3,:); %knR “àù +
 Jlocal(3,3).v(2,:) = -Jlocal(3,3).v(2,:); %ankR “à“] +
 Jlocal(3,3).v(3,:) = -Jlocal(3,3).v(3,:); %ankR ŠOù +
 
%------------------------
%group4
%------------------------



%------------------------
%group5
%------------------------

Jlocal(5,2).v(1,:) = -Jlocal(5,2).v(1,:); %ribC L“W +
Jlocal(5,2).v(2,:) = -Jlocal(5,2).v(2,:); %ribC ‰EŒX +
Jlocal(5,2).v(3,:) = -Jlocal(5,2).v(3,:); %ribC ¶‰ñù +

end
     
     
end
