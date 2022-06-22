function d=dif3(date,nFr,time_int)

%dat : 微分したいデータ
%nFr : フレーム数
%time_int : 時間間隔

d(:,1)=(-3*date(:,1)+4*date(:,2)-date(:,3))/(2*time_int);

for iFr=2:nFr-1
    d(:,iFr)=(-date(:,iFr-1)+date(:,iFr+1))/(2*time_int);
end

d(:,nFr)=(date(:,nFr-2)-4*date(:,nFr-1)+3*date(:,nFr))/(2*time_int);
end