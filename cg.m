function [cg,bsp] =cg(n,mass,sex)

%Input
%n:ポイント名
%mass:被験者の体重
%sex:性別
%time_int:時間間隔

%Output
%cg:各セグメントと全身の重心データ
%bsp:慣性主軸が一致した慣性テンソル

%阿江 (1992) 参照

%BSP.m  1. head
%       2. uarm
%       3. farm
%       4. hand
%       5. thigh
%       6. shank
%       7. foot
%       8. upper trunk (慣性モーメントの算出が異なる)
%       9. middle trunk (慣性モーメントの算出が異なる)
%       10. lower trunk (慣性モーメントの算出が異なる)

if sex == 'm'
    filename = 'BSP.m.txt';
elseif sex == 'f'
    filename = 'BSP.f.txt';
end

BSPdata = dlmread(filename,'	',0,0);

bsp = getbsp(n,mass,BSPdata);

cg = Getcg(n,BSPdata);

end


function bsp = getbsp(n,mass,BSPdata)

[nseg,~] = size(BSPdata); %BSPdata=dlmread(filename,' ',1,1)

V = getV(n);

for iseg = 1:nseg
    
    Lseg = sqrt(sum(V(:,iseg).*V(:,iseg))); %セグメントの長さ
    bspdata(iseg,1) = mass*(BSPdata(iseg,1)/100); %　各セグメントのセグメント質量:体重×質量比 
    bspdata(iseg,2) = bspdata(iseg,1)*(Lseg*((BSPdata(iseg,3)/100))*(Lseg*(BSPdata(iseg,3)/100))); % x軸周りの慣性モーメント=セグメント質量×回転半径^2
    bspdata(iseg,3) = bspdata(iseg,1)*(Lseg*((BSPdata(iseg,4)/100))*(Lseg*(BSPdata(iseg,4)/100))); % y軸周りの慣性モーメント
    bspdata(iseg,4) = bspdata(iseg,1)*(Lseg*((BSPdata(iseg,5)/100))*(Lseg*(BSPdata(iseg,5)/100))); % z軸周りの慣性モーメント

end
    
        bsp(1).m = bspdata(6,1);%Right Hand mass
        bsp(2).m = bspdata(5,1);%Right Farm mass
        bsp(3).m = bspdata(4,1);%Right Uarm mass
        bsp(4).m = bspdata(6,1);%Left Hand mass
        bsp(5).m = bspdata(5,1);%Left Farm mass
        bsp(6).m = bspdata(4,1);%Left Uarm mass
        bsp(7).m = bspdata(9,1);%Right foot mass
        bsp(8).m = bspdata(8,1);%Right shank mass
        bsp(9).m = bspdata(7,1);%Right thigh mass
        bsp(10).m = bspdata(9,1);%Left foot mass
        bsp(11).m = bspdata(8,1);%Left shank mass
        bsp(12).m = bspdata(7,1);%Left thigh mass
        bsp(13).m = bspdata(1,1);%Head mass
        bsp(14).m = bspdata(2,1);%upper torso mass
        bsp(15).m = bspdata(3,1);%lower torso mass
     
        bsp(1).I = bspdata(6,2:4);%Right Hand inertia
        bsp(2).I = bspdata(5,2:4);%Right Farm inertia
        bsp(3).I = bspdata(4,2:4);%Right Uarm inertia
        bsp(4).I = bspdata(6,2:4);%Left Hand inertia
        bsp(5).I = bspdata(5,2:4);%Left Farm inertia
        bsp(6).I = bspdata(4,2:4);%Left Uarm inertia
        bsp(7).I = bspdata(9,2:4);%Right foot inertia
        bsp(8).I = bspdata(8,2:4);%Right shank inertia
        bsp(9).I = bspdata(7,2:4);%Right thigh inertia
        bsp(10).I = bspdata(9,2:4);%Left foot inertia
        bsp(11).I = bspdata(8,2:4);%Left shank inertia
        bsp(12).I = bspdata(7,2:4);%Left thigh inertia
        bsp(13).I = bspdata(1,2:4);%Head inertia
        bsp(14).I = bspdata(2,2:4);%upper torso inertia
        bsp(15).I = bspdata(3,2:4);%lower torso inertia

end


function V = getV(n)

[~,nFr] = size(n.handR);
V(:,1) = n.head(:,round(nFr/2))-n.clav(:,round(nFr/2)); 
V(:,2) = n.clav(:,round(nFr/2))-n.ribC(:,round(nFr/2)); 
V(:,3) = n.ribC(:,round(nFr/2))-n.troC(:,round(nFr/2)); 
V(:,4) = n.shR(:,round(nFr/2))-n.elbR(:,round(nFr/2));
V(:,5) = n.elbR(:,round(nFr/2))-n.wrR(:,round(nFr/2));
V(:,6) = n.wrR(:,round(nFr/2))-n.handR(:,round(nFr/2));
V(:,7) = n.hipR(:,round(nFr/2))-n.knR(:,round(nFr/2));
V(:,8) = n.knR(:,round(nFr/2))-n.anR(:,round(nFr/2));
V(:,9) = n.toeR(:,round(nFr/2))-n.heelR(:,round(nFr/2));

% 右と左は同じだから左の分は作っていない

end

function cg = Getcg(n,BSPdata)

cg(1).cg = n.handR*(BSPdata(5,2)/100)+n.wrR*(1-BSPdata(5,2)/100);%Right Hand  %近位から遠位 %内分点の算出: OG=OW+89.1/100WH=OW+89.1/100(OH-OW)=10.9/100OW+89.1/100OH
cg(2).cg = n.wrR*(BSPdata(4,2)/100)+n.elbR*(1-BSPdata(4,2)/100);%Right Farm
cg(3).cg = n.elbR*(BSPdata(3,2)/100) +n.shR*(1-BSPdata(3,2)/100);%Right Uarm 

cg(4).cg = n.handL*(BSPdata(5,2)/100)+n.wrL*(1-BSPdata(5,2)/100);%Left Hand
cg(5).cg = n.wrL*(BSPdata(4,2)/100)+n.elbL*(1-BSPdata(4,2)/100);%Left Farm
cg(6).cg = n.elbL*(BSPdata(3,2)/100) +n.shL*(1-BSPdata(3,2)/100);%Left Uarm  

cg(7).cg = n.heelR*(BSPdata(9,2)/100)+n.toeR*(1-BSPdata(9,2)/100);%Right foot　%footはつま先から
cg(8).cg = n.anR*(BSPdata(8,2)/100)+n.knR*(1-BSPdata(8,2)/100);%Right shank
cg(9).cg = n.knR*(BSPdata(7,2)/100)+n.hipR*(1-BSPdata(7,2)/100);%Right thigh
 
cg(10).cg = n.heelL*(BSPdata(9,2)/100)+n.toeL*(1-BSPdata(9,2)/100);%Left foot
cg(11).cg = n.anL*(BSPdata(8,2)/100)+n.knL*(1-BSPdata(8,2)/100);%Left shank
cg(12).cg = n.knL*(BSPdata(7,2)/100)+n.hipL*(1-BSPdata(7,2)/100);%Left thigh

cg(13).cg = n.ear*(BSPdata(1,2)/100)+n.head*(1-BSPdata(1,2)/100);%Head&neck
cg(14).cg = n.ribC*(BSPdata(2,2)/100)+n.clav*(1-BSPdata(2,2)/100);%upper torso
cg(15).cg = n.troC*(BSPdata(3,2)/100)+n.ribC*(1-BSPdata(3,2)/100);%lower torso

cg(16).cg = cg(1).cg*(BSPdata(6,1)/100)+cg(2).cg*(BSPdata(5,1)/100)+cg(3).cg*(BSPdata(4,1)/100)+...
            cg(4).cg*(BSPdata(6,1)/100)+cg(5).cg*(BSPdata(5,1)/100)+cg(6).cg*(BSPdata(4,1)/100)+ ...
            cg(7).cg*(BSPdata(9,1)/100)+cg(8).cg*(BSPdata(8,1)/100)+cg(9).cg*(BSPdata(7,1)/100)+...
            cg(10).cg*(BSPdata(9,1)/100)+cg(11).cg*(BSPdata(8,1)/100)+cg(12).cg*(BSPdata(7,1)/100)+ ...
            cg(13).cg*(BSPdata(1,1)/100)+cg(14).cg*(BSPdata(2,1)/100)+cg(15).cg*(BSPdata(3,1)/100); %重心（全身の質量中心）
 
end


 
