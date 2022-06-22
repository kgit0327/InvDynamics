 function JT = transJntN(FN,Unit,mass)
 
%ÎŒğÀ•WŒn‚Ö‚Ì“Š‰e‚É‚Â‚¢‚Ä‚ÍDesroches, Cheze,& Dumas, (2010) ‚ğQÆ
    
%-------------
%  1:shR
%  2:elbR
%  3:wrR
%  4:shL
%  5:elbL
%  6:wrL
%  7:hipR
%  8:kneeR
%  9:ankR
% 10:hipL
% 11:kneeL
% 12:ankL
% 13:neck
% 14:ribC
%-------------

[~,nFr] = size(FN(1,1).F);

for iFr = 1:nFr

    for iGrp=1:5

        if iGrp == 5
            nJnt = 2;
        else
            nJnt = 3;
        end
        
        for iJnt = 1:nJnt
            
            Jnt(iGrp,iJnt).T(:,iFr) = (Unit(iGrp).JCS(iJnt).Var(iFr).R)\FN(iGrp,iJnt).N(:,iFr)./mass; %ŠÖßÀ•WŒn‚Ö‚Ì“Š‰e
            
        end 
        
    end
    
end

Jnt = modifyAxis(Jnt);


JT = [Jnt(1,1).T;...     %shR (…•½‹ü‹È+ “à“]+ “àù+)
      Jnt(1,2).T;...     %elbR (L“W+ “à”½+ ‰ñ“à+)
      Jnt(1,3).T;...     %wrR (¶‹ü + ô‹ü + )
      Jnt(2,1).T;...     %shL (…•½‹ü‹È+ ŠO“]+ “àù+)
      Jnt(2,2).T;...     %elbL (L“W+ “à”½+ ‰ñ“à+)
      Jnt(2,3).T;...     %wrL (¶‹ü + ô‹ü + )
      Jnt(3,1).T;...     %hipR (‹ü‹È+ ŠO“]+ ŠOù+)
      Jnt(3,2).T;...     %knR (L“W+ ŠO”½+ “àù+)
      Jnt(3,3).T;...     %anR( ”w‹ü + “à“]+ ŠOù +)
      Jnt(4,1).T;...     %hipL (‹ü‹È+ ŠO“]+ ŠOù+)
      Jnt(4,2).T;...     %knL (L“W+ ŠO”½+ “àù+)
      Jnt(4,3).T;...     %anL ( ”w‹ü + “à“]+ ŠOù +)
      Jnt(5,1).T;...     %neck (L“W+ ‰EŒX+ ¶‰ñù+)
      Jnt(5,2).T;...     %tl (L“W+ ‰EŒX+ ¶‰ñù+)
                    ];

end

function     Jnt = modifyAxis(Jnt)

%------------------------
%group1
%------------------------

Jnt(1,1).T(2,:) = -Jnt(1,1).T(2,:); %shR “à“]+
Jnt(1,2).T(1,:) = -Jnt(1,2).T(1,:); %elbR L“W +
Jnt(1,3).T(2,:) = -Jnt(1,3).T(2,:); %wrR Ú‹ü +

%------------------------
%group1
%------------------------

Jnt(2,1).T(2,:) = -Jnt(2,1).T(2,:); %shL “à“]+
Jnt(2,1).T(3,:) = -Jnt(2,1).T(3,:); %shL “àù+
Jnt(2,2).T(1,:) = -Jnt(2,2).T(1,:); %elbL L“W +
Jnt(2,2).T(2,:) = -Jnt(2,2).T(2,:); %elbL “à”½ +
Jnt(2,2).T(3,:) = -Jnt(2,2).T(3,:); %elbL ‰ñ“à +
Jnt(2,3).T(3,:) = -Jnt(2,3).T(3,:); %wrL ‰ñ“à +

%------------------------
%group3
%------------------------

 Jnt(3,1).T(2,:) = -Jnt(3,1).T(2,:); %hipR ŠO“] +
 Jnt(3,1).T(3,:) = -Jnt(3,1).T(3,:); %hipR ŠOù +
 Jnt(3,2).T(2,:) = -Jnt(3,2).T(2,:); %knR ŠO”½ +
 Jnt(3,2).T(3,:) = -Jnt(3,2).T(3,:); %knR “àù +
 Jnt(3,3).T(2,:) = -Jnt(3,3).T(2,:); %anR “à“] +
 Jnt(3,3).T(3,:) = -Jnt(3,3).T(3,:); %anR ŠOù +
 
%------------------------
%group4
%------------------------



%------------------------
%group5
%------------------------

 Jnt(5,2).T(1,:) = -Jnt(5,2).T(1,:); %ribC L“W +
 Jnt(5,2).T(2,:) = -Jnt(5,2).T(2,:); %ribC ‰EŒX +
 Jnt(5,2).T(3,:) = -Jnt(5,2).T(3,:); %ribC ¶‰ñù +

end
