
function main 
%% -----------------------------------------------------------------
 
filename = 'APSingle_1'; %ファイル名

time_int = 1/200; %1コマあたりの時間
  
mass = 55; %被験者の体重(kg)
         
%% Reading FP & motion file ----------------------------------------

[FP,M_data,nFr,racket_M_data] = read_FP_motion(filename);
fr = nFr;  
  
%% Smoothing (Winter, 2009) ----------------------------------------

% point = 47; %貼付したマーカーの数
point = 48; %貼付したマーカーの数
[sdata,ocf] = autosmooth(M_data,point,nFr,time_int,'g'); %スムージング後のmotiondataと最適遮断周波数
% [Racket_MotionData, ~] = autosmooth(racket_M_data, 7, nFr, time_int, 'g');

% sdata = M_data;

MaxocfX = max(ocf(:,1)); MinocfX = min(ocf(:,1)); %最適遮断周波数の最大値と最小値
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
  
RJ = get_RJ(SCS,nFr); %角度チェックプログラム
 
Jnt_angle = get_Euler2(RJ,nFr,njnt); %角度チェックプログラム

%% Joint torques and angular velocity (local) ----------------------

JT = transJntN(FN,Unit,mass); % Global→Local (座標変換)
    
JAV = get_JAV(segdat,Unit); % Global→Local (座標変換)
 
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
