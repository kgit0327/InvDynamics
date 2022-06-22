function JAV = get_JAV(segdat,Unit)

[~,nFr] = size(segdat(3).seganV_GCS);

%�֐߂ɑ΂��鉓�ʂ̃Z�O�����g���`
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

%�֐߂ɑ΂���߈ʂ̃Z�O�����g���`
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
    
JAV = [Jlocal(1,1).v;...     %shR (��������+ �O�]+ ����+)
       Jlocal(1,2).v;...     %elbR (�L�W+ ����+ ���+)
       Jlocal(1,3).v;...     %wrR (���� + ��� + )
       Jlocal(2,1).v;...     %shL (��������+ �O�]+ ����+)
       Jlocal(2,2).v;...     %elbL (�L�W+ ����+ ���+)
       Jlocal(2,3).v;...     %wrL (���� + ��� + )
       Jlocal(3,1).v;...     %hipR (����+ �O�]+ �O��+)
       Jlocal(3,2).v;...     %knR (�L�W+ �O��+ ����+)
       Jlocal(3,3).v;...     %anR( �w�� + ���]+ �O�� +)
       Jlocal(4,1).v;...     %hipL (����+ �O�]+ �O��+)
       Jlocal(4,2).v;...     %knL (�L�W+ �O��+ ����+)
       Jlocal(4,3).v;...     %anL ( �w�� + ���]+ �O�� +)
       Jlocal(5,1).v;...     %neck (�L�W+ �E�X+ �����+)
       Jlocal(5,2).v;...     %torso (�L�W+ �E�X+ �����+)
                    ];
          
function Jlocal = modifyAxis(Jlocal)

%------------------------
%group1
%------------------------

Jlocal(1,1).v(2,:) = -Jlocal(1,1).v(2,:); %shR ���]+
Jlocal(1,2).v(1,:) = -Jlocal(1,2).v(1,:); %elbR �L�W +
Jlocal(1,3).v(2,:) = -Jlocal(1,3).v(2,:); %wrR �ڋ� +

%------------------------
%group2
%------------------------

Jlocal(2,1).v(2,:) = -Jlocal(2,1).v(2,:); %shL ���]+
Jlocal(2,1).v(3,:) = -Jlocal(2,1).v(3,:); %shL ����+
Jlocal(2,2).v(1,:) = -Jlocal(2,2).v(1,:); %elbL �L�W +
Jlocal(2,2).v(2,:) = -Jlocal(2,2).v(2,:); %elbL ���� +
Jlocal(2,2).v(3,:) = -Jlocal(2,2).v(3,:); %elbL ��� +
Jlocal(2,3).v(3,:) = -Jlocal(2,3).v(3,:); %wrL ��� +

%------------------------
%group3
%------------------------

 Jlocal(3,1).v(2,:) = -Jlocal(3,1).v(2,:); %hipR �O�] +
 Jlocal(3,1).v(3,:) = -Jlocal(3,1).v(3,:); %hipR �O�� +
 Jlocal(3,2).v(2,:) = -Jlocal(3,2).v(2,:); %knR �O�� +
 Jlocal(3,2).v(3,:) = -Jlocal(3,2).v(3,:); %knR ���� +
 Jlocal(3,3).v(2,:) = -Jlocal(3,3).v(2,:); %ankR ���] +
 Jlocal(3,3).v(3,:) = -Jlocal(3,3).v(3,:); %ankR �O�� +
 
%------------------------
%group4
%------------------------



%------------------------
%group5
%------------------------

Jlocal(5,2).v(1,:) = -Jlocal(5,2).v(1,:); %ribC �L�W +
Jlocal(5,2).v(2,:) = -Jlocal(5,2).v(2,:); %ribC �E�X +
Jlocal(5,2).v(3,:) = -Jlocal(5,2).v(3,:); %ribC ����� +

end
     
     
end
