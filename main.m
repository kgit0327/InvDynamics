
function main 
%% -----------------------------------------------------------------
 
filename = 'APSingle_1'; %�t�@�C����

time_int = 1/200; %1�R�}������̎���
  
mass = 55; %�팱�҂̑̏d(kg)
         
%% Reading FP & motion file ----------------------------------------

[FP,M_data,nFr,racket_M_data] = read_FP_motion(filename);
fr = nFr;  
  
%% Smoothing (Winter, 2009) ----------------------------------------

% point = 47; %�\�t�����}�[�J�[�̐�
point = 48; %�\�t�����}�[�J�[�̐�
[sdata,ocf] = autosmooth(M_data,point,nFr,time_int,'g'); %�X���[�W���O���motiondata�ƍœK�Ւf���g��
% [Racket_MotionData, ~] = autosmooth(racket_M_data, 7, nFr, time_int, 'g');

% sdata = M_data;

MaxocfX = max(ocf(:,1)); MinocfX = min(ocf(:,1)); %�œK�Ւf���g���̍ő�l�ƍŏ��l
MaxocfY = max(ocf(:,2)); MinocfY = min(ocf(:,2));
MaxocfZ = max(ocf(:,3)); MinocfZ = min(ocf(:,3));
                                
dat = sdata';
    
nseg = 15; njnt = 14;
    
%% Naming each Point -----------------------------------------------
 
n = set_Pname47(dat, racket_M_data);

%% Segment Cooridinate system --------------------------------------
 
SCS = set_SCS(n);
 
%% Segment angle ---------------------------------------------------
 
R = get_R(SCS,nFr);
 
Seg_angle = get_Euler(R,nFr,nseg); 

%% Center of mass & inertia ----------------------------------------
     
[cgdat,bsp] = cg(n,mass,'m');

%% Segment kinematics data -----------------------------------------
 
segdat = get_segdat(bsp,cgdat,SCS,nFr,time_int,nseg); 
 
%% Joint forces and torques (global) -------------------------------

FN = get_JntFN(n,segdat,nFr,FP);

%% Definition Joint Cooridinate System & Calculating Joint angle ---
 
Unit = set_JCS_JA(nFr,SCS);
  
RJ = get_RJ(SCS,nFr); %�p�x�`�F�b�N�v���O����
 
Jnt_angle = get_Euler2(RJ,nFr,njnt); %�p�x�`�F�b�N�v���O����

%% Joint torques and angular velocity (local) ----------------------

JT = transJntN(FN,Unit,mass); % Global��Local (���W�ϊ�)
    
JAV = get_JAV(segdat,Unit); % Global��Local (���W�ϊ�)
 
%% Joint torque and force power ------------------------------------

JTP = get_JntTP(JAV,JT);
 
JFP = get_JntFP(FN,n,mass,time_int,nFr);

%% Joint Work ------------------------------------------------------

JW = get_JntWork(JFP,JTP,time_int);
  
%% Time normalization ----------------------------------------------

% JT_nl = get_JTnl(JT,FP,cgdat,time_int,njnt,nFr); %time_norlization
 
%% Save file -------------------------------------------------------


 save([filename, '_']);
 filename

end
