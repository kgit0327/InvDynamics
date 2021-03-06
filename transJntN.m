 function JT = transJntN(FN,Unit,mass)
 
%斜交座標系への投影についてはDesroches, Cheze,& Dumas, (2010) を参照
    
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
            
            Jnt(iGrp,iJnt).T(:,iFr) = (Unit(iGrp).JCS(iJnt).Var(iFr).R)\FN(iGrp,iJnt).N(:,iFr)./mass; %関節座標系への投影
            
        end 
        
    end
    
end

Jnt = modifyAxis(Jnt);


JT = [Jnt(1,1).T;...     %shR (水平屈曲+ 内転+ 内旋+)
      Jnt(1,2).T;...     %elbR (伸展+ 内反+ 回内+)
      Jnt(1,3).T;...     %wrR (掌屈 + 橈屈 + )
      Jnt(2,1).T;...     %shL (水平屈曲+ 外転+ 内旋+)
      Jnt(2,2).T;...     %elbL (伸展+ 内反+ 回内+)
      Jnt(2,3).T;...     %wrL (掌屈 + 橈屈 + )
      Jnt(3,1).T;...     %hipR (屈曲+ 外転+ 外旋+)
      Jnt(3,2).T;...     %knR (伸展+ 外反+ 内旋+)
      Jnt(3,3).T;...     %anR( 背屈 + 内転+ 外旋 +)
      Jnt(4,1).T;...     %hipL (屈曲+ 外転+ 外旋+)
      Jnt(4,2).T;...     %knL (伸展+ 外反+ 内旋+)
      Jnt(4,3).T;...     %anL ( 背屈 + 内転+ 外旋 +)
      Jnt(5,1).T;...     %neck (伸展+ 右傾+ 左回旋+)
      Jnt(5,2).T;...     %tl (伸展+ 右傾+ 左回旋+)
                    ];

end

function     Jnt = modifyAxis(Jnt)

%------------------------
%group1
%------------------------

Jnt(1,1).T(2,:) = -Jnt(1,1).T(2,:); %shR 内転+
Jnt(1,2).T(1,:) = -Jnt(1,2).T(1,:); %elbR 伸展 +
Jnt(1,3).T(2,:) = -Jnt(1,3).T(2,:); %wrR 尺屈 +

%------------------------
%group1
%------------------------

Jnt(2,1).T(2,:) = -Jnt(2,1).T(2,:); %shL 内転+
Jnt(2,1).T(3,:) = -Jnt(2,1).T(3,:); %shL 内旋+
Jnt(2,2).T(1,:) = -Jnt(2,2).T(1,:); %elbL 伸展 +
Jnt(2,2).T(2,:) = -Jnt(2,2).T(2,:); %elbL 内反 +
Jnt(2,2).T(3,:) = -Jnt(2,2).T(3,:); %elbL 回内 +
Jnt(2,3).T(3,:) = -Jnt(2,3).T(3,:); %wrL 回内 +

%------------------------
%group3
%------------------------

 Jnt(3,1).T(2,:) = -Jnt(3,1).T(2,:); %hipR 外転 +
 Jnt(3,1).T(3,:) = -Jnt(3,1).T(3,:); %hipR 外旋 +
 Jnt(3,2).T(2,:) = -Jnt(3,2).T(2,:); %knR 外反 +
 Jnt(3,2).T(3,:) = -Jnt(3,2).T(3,:); %knR 内旋 +
 Jnt(3,3).T(2,:) = -Jnt(3,3).T(2,:); %anR 内転 +
 Jnt(3,3).T(3,:) = -Jnt(3,3).T(3,:); %anR 外旋 +
 
%------------------------
%group4
%------------------------



%------------------------
%group5
%------------------------

 Jnt(5,2).T(1,:) = -Jnt(5,2).T(1,:); %ribC 伸展 +
 Jnt(5,2).T(2,:) = -Jnt(5,2).T(2,:); %ribC 右傾 +
 Jnt(5,2).T(3,:) = -Jnt(5,2).T(3,:); %ribC 左回旋 +

end
