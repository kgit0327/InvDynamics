 function JT = transJntN(FN,Unit,mass)
 
%�Ό����W�n�ւ̓��e�ɂ��Ă�Desroches, Cheze,& Dumas, (2010) ���Q��
    
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
            
            Jnt(iGrp,iJnt).T(:,iFr) = (Unit(iGrp).JCS(iJnt).Var(iFr).R)\FN(iGrp,iJnt).N(:,iFr)./mass; %�֐ߍ��W�n�ւ̓��e
            
        end 
        
    end
    
end

Jnt = modifyAxis(Jnt);


JT = [Jnt(1,1).T;...     %shR (��������+ ���]+ ����+)
      Jnt(1,2).T;...     %elbR (�L�W+ ����+ ���+)
      Jnt(1,3).T;...     %wrR (���� + ��� + )
      Jnt(2,1).T;...     %shL (��������+ �O�]+ ����+)
      Jnt(2,2).T;...     %elbL (�L�W+ ����+ ���+)
      Jnt(2,3).T;...     %wrL (���� + ��� + )
      Jnt(3,1).T;...     %hipR (����+ �O�]+ �O��+)
      Jnt(3,2).T;...     %knR (�L�W+ �O��+ ����+)
      Jnt(3,3).T;...     %anR( �w�� + ���]+ �O�� +)
      Jnt(4,1).T;...     %hipL (����+ �O�]+ �O��+)
      Jnt(4,2).T;...     %knL (�L�W+ �O��+ ����+)
      Jnt(4,3).T;...     %anL ( �w�� + ���]+ �O�� +)
      Jnt(5,1).T;...     %neck (�L�W+ �E�X+ �����+)
      Jnt(5,2).T;...     %tl (�L�W+ �E�X+ �����+)
                    ];

end

function     Jnt = modifyAxis(Jnt)

%------------------------
%group1
%------------------------

Jnt(1,1).T(2,:) = -Jnt(1,1).T(2,:); %shR ���]+
Jnt(1,2).T(1,:) = -Jnt(1,2).T(1,:); %elbR �L�W +
Jnt(1,3).T(2,:) = -Jnt(1,3).T(2,:); %wrR �ڋ� +

%------------------------
%group1
%------------------------

Jnt(2,1).T(2,:) = -Jnt(2,1).T(2,:); %shL ���]+
Jnt(2,1).T(3,:) = -Jnt(2,1).T(3,:); %shL ����+
Jnt(2,2).T(1,:) = -Jnt(2,2).T(1,:); %elbL �L�W +
Jnt(2,2).T(2,:) = -Jnt(2,2).T(2,:); %elbL ���� +
Jnt(2,2).T(3,:) = -Jnt(2,2).T(3,:); %elbL ��� +
Jnt(2,3).T(3,:) = -Jnt(2,3).T(3,:); %wrL ��� +

%------------------------
%group3
%------------------------

 Jnt(3,1).T(2,:) = -Jnt(3,1).T(2,:); %hipR �O�] +
 Jnt(3,1).T(3,:) = -Jnt(3,1).T(3,:); %hipR �O�� +
 Jnt(3,2).T(2,:) = -Jnt(3,2).T(2,:); %knR �O�� +
 Jnt(3,2).T(3,:) = -Jnt(3,2).T(3,:); %knR ���� +
 Jnt(3,3).T(2,:) = -Jnt(3,3).T(2,:); %anR ���] +
 Jnt(3,3).T(3,:) = -Jnt(3,3).T(3,:); %anR �O�� +
 
%------------------------
%group4
%------------------------



%------------------------
%group5
%------------------------

 Jnt(5,2).T(1,:) = -Jnt(5,2).T(1,:); %ribC �L�W +
 Jnt(5,2).T(2,:) = -Jnt(5,2).T(2,:); %ribC �E�X +
 Jnt(5,2).T(3,:) = -Jnt(5,2).T(3,:); %ribC ����� +

end
