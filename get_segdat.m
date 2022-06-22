function segdat = get_segdat(bsp,cgdat,SCS,nFr,time_int,nseg)

%segdat.cg      %�d�S�ʒu
%segdat.cgV     %�d�S���x
%segdat.cgA     %�d�S�����x
%segdat.seganV_GCS  %�Z�O�����g�p���x(GCS)
%segdat.seganA_GCS  %�Z�O�����g�p�����x(GCS)
%segdat.seganV_LCS  %�Z�O�����g�p���x(LCS)
%segdat.I_GCS   %�����厲�Ɉ�v���Ȃ����܂��̊����e���\��%
%segdat.L   %�p�^����
%segdat.N   %�p�^���ʂ̔���
%segdat.mg  %�d��
%segdat.ma  %�^���������̍���
    
for iseg = 1:nseg
    
    segdat(iseg) = getsegdat(bsp(iseg),cgdat(iseg),SCS(iseg),nFr,time_int);
    
end

end


function segdat = getsegdat(bsp,cgdat,SCS,nFr,time_int)

cgV = dif3(cgdat.cg,nFr,time_int);
cgA = dif3(cgV,nFr,time_int);

%�P�ʃx�N�g���̔����ɂ��p���x�̎Z�o------------------------------------------
%---------------------------------------------------------------------------

for iFr = 1:nFr
    
    CS = SCS.Var(iFr).R;
	lcs.i(:,iFr) = CS(:,1);
	lcs.j(:,iFr) = CS(:,2);
	lcs.k(:,iFr) = CS(:,3);
    
end
    
lcs.id = dif3(lcs.i,nFr,time_int);
lcs.jd = dif3(lcs.j,nFr,time_int);
lcs.kd = dif3(lcs.k,nFr,time_int);

I_LCS = diag(bsp.I);  %�����厲�Ɉ�v���鎲�܂��(LCS)�̊����e���\��
    
for iFr = 1:nFr
    
    seganV_LCS(:,iFr) = [dot(lcs.k(:,iFr),lcs.jd(:,iFr));...
                         dot(lcs.i(:,iFr),lcs.kd(:,iFr));...
                         dot(lcs.j(:,iFr),lcs.id(:,iFr))];                  % LCS�̊p���x
    
    R = SCS.Var(iFr).R;                                                     % ���W�ϊ��s��
       
    seganV_GCS(:,iFr) = R*seganV_LCS(:,iFr);                                % LCS�Z�O�����g�p���x��GCS�ւ̍��W�ϊ�
       
    I_GCS(iFr).I = R*I_LCS*R';                                              % �����厲�Ɉ�v���Ȃ����܂��(GCS)�̊����e���\��
       
    segdat.I_GCS(iFr).I = R*I_LCS*R';
       
    L(:,iFr) = I_GCS(iFr).I*seganV_GCS(:,iFr);                              % �p�^����
       
    Krot(:,iFr) = (bsp.I*(seganV_LCS(:,iFr).*seganV_LCS(:,iFr)))/2;         % ��]�̃G�l���M�[
 
    V = sqrt(sum(cgV(:,iFr).*cgV(:,iFr)));
    Ktra(:,iFr) = (bsp.m*V*V)/2;                                            % ���i�̃G�l���M�[
       
    U(:,iFr) = bsp.m*9.807*cgdat.cg(3,iFr);                                 % �ʒu�G�l���M�[
    g = [0;0;-9.807];
    gg(:,iFr) = g;
        
    mg(:,iFr) = bsp.m*gg(:,iFr);                                    
	ma(:,iFr) = bsp.m*cgA(:,iFr);                                    
    
end
       
    seganA_GCS = dif3(seganV_GCS,nFr,time_int);                             % ��΍��W�n�ɂ�����Z�O�����g�̊p�����x
    
    N = dif3(L,nFr,time_int);                                               % �p�^���ʂ̔���
     
    E = Krot+Ktra+U;                                                        % �G�l���M�[�̑��a 
    
    
    segdat.cg           = cgdat.cg;             %�d�S�ʒu
	segdat.cgV          = cgV;                	%�d�S���x
	segdat.cgA          = cgA;                  %�d�S�����x
    segdat.seganV_GCS	= seganV_GCS;			%�Z�O�����g�p���x(GCS)
	segdat.seganA_GCS   = seganA_GCS;			%�Z�O�����g�p�����x(GCS)
	segdat.seganV_LCS	= seganV_LCS;			%�Z�O�����g�p���x(LCS)
    segdat.I_LCS        = I_LCS;                %�����厲�Ɉ�v���銵���e���\��
    segdat.I_GCS        = I_GCS;                %�����厲�Ɉ�v���Ȃ����܂��̊����e���\��
	segdat.L            = L; 					%�p�^����
	segdat.N            = N;         			%�p�^���ʂ̔���
    segdat.mg           = mg;                   %�d��
    segdat.ma           = ma;                   %�^���������̍���
    segdat.Krot         = Krot;                 %��]�̃G�l���M�[
    segdat.Ktra         = Ktra;                 %���i�̃G�l���M�[
    segdat.U            = U;                    %�ʒu�G�l���M�[
    segdat.E            = E;                    %�S�G�l���M�[           

end

