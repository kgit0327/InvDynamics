function d=dif3(date,nFr,time_int)

%dat : �����������f�[�^
%nFr : �t���[����
%time_int : ���ԊԊu

d(:,1)=(-3*date(:,1)+4*date(:,2)-date(:,3))/(2*time_int);

for iFr=2:nFr-1
    d(:,iFr)=(-date(:,iFr-1)+date(:,iFr+1))/(2*time_int);
end

d(:,nFr)=(date(:,nFr-2)-4*date(:,nFr-1)+3*date(:,nFr))/(2*time_int);
end