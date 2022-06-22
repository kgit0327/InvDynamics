function JT_nl = get_JTnl(JT,FP,cgdat,time_int,njnt,nFr)

cg_zv = dif3(cgdat(16).cg(end,:),nFr,time_int);
start = find(cg_zv < -0.1, 1, 'first'); %�d�S���������ɓ����n�߂��R�}���𒊏o
finish = find(FP(2).grf(3,:) == 0, 1, 'first'); %���n�����R�}���𒊏o

flame = finish - start; %�K�i���������͈͂̃R�}��
Timeflame = (0:(time_int):flame*(time_int)); %�K�i���������͈͂̎���
  
MaxTf = max(Timeflame);
interTf = MaxTf/100; %�K�i���������͈͂�100�R�}�ɂ���ۂ�1�R�}������̎���
TimeCC = (0:interTf:MaxTf); %�V�������Ԏ� (0%�`100%)
 
 npoint = 3*njnt;
 
 for ipoint = 1:npoint
     
     data(1,ipoint).p = JT(ipoint,:);
     ndata(ipoint,:) = interp1(Timeflame,data(1,ipoint).p(start:finish),TimeCC,'spline'); %3���X�v���C�����
     
 end
 
 JT_nl = ndata;
 
end