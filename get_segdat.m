function segdat = get_segdat(bsp,cgdat,SCS,nFr,time_int,nseg)

%segdat.cg      %重心位置
%segdat.cgV     %重心速度
%segdat.cgA     %重心加速度
%segdat.seganV_GCS  %セグメント角速度(GCS)
%segdat.seganA_GCS  %セグメント角加速度(GCS)
%segdat.seganV_LCS  %セグメント角速度(LCS)
%segdat.I_GCS   %慣性主軸に一致しない軸まわりの慣性テンソル%
%segdat.L   %角運動量
%segdat.N   %角運動量の微分
%segdat.mg  %重力
%segdat.ma  %運動方程式の左辺
    
for iseg = 1:nseg
    
    segdat(iseg) = getsegdat(bsp(iseg),cgdat(iseg),SCS(iseg),nFr,time_int);
    
end

end


function segdat = getsegdat(bsp,cgdat,SCS,nFr,time_int)

cgV = dif3(cgdat.cg,nFr,time_int);
cgA = dif3(cgV,nFr,time_int);

%単位ベクトルの微分による角速度の算出------------------------------------------
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

I_LCS = diag(bsp.I);  %慣性主軸に一致する軸まわり(LCS)の慣性テンソル
    
for iFr = 1:nFr
    
    seganV_LCS(:,iFr) = [dot(lcs.k(:,iFr),lcs.jd(:,iFr));...
                         dot(lcs.i(:,iFr),lcs.kd(:,iFr));...
                         dot(lcs.j(:,iFr),lcs.id(:,iFr))];                  % LCSの角速度
    
    R = SCS.Var(iFr).R;                                                     % 座標変換行列
       
    seganV_GCS(:,iFr) = R*seganV_LCS(:,iFr);                                % LCSセグメント角速度のGCSへの座標変換
       
    I_GCS(iFr).I = R*I_LCS*R';                                              % 慣性主軸に一致しない軸まわり(GCS)の慣性テンソル
       
    segdat.I_GCS(iFr).I = R*I_LCS*R';
       
    L(:,iFr) = I_GCS(iFr).I*seganV_GCS(:,iFr);                              % 角運動量
       
    Krot(:,iFr) = (bsp.I*(seganV_LCS(:,iFr).*seganV_LCS(:,iFr)))/2;         % 回転のエネルギー
 
    V = sqrt(sum(cgV(:,iFr).*cgV(:,iFr)));
    Ktra(:,iFr) = (bsp.m*V*V)/2;                                            % 並進のエネルギー
       
    U(:,iFr) = bsp.m*9.807*cgdat.cg(3,iFr);                                 % 位置エネルギー
    g = [0;0;-9.807];
    gg(:,iFr) = g;
        
    mg(:,iFr) = bsp.m*gg(:,iFr);                                    
	ma(:,iFr) = bsp.m*cgA(:,iFr);                                    
    
end
       
    seganA_GCS = dif3(seganV_GCS,nFr,time_int);                             % 絶対座標系におけるセグメントの角加速度
    
    N = dif3(L,nFr,time_int);                                               % 角運動量の微分
     
    E = Krot+Ktra+U;                                                        % エネルギーの総和 
    
    
    segdat.cg           = cgdat.cg;             %重心位置
	segdat.cgV          = cgV;                	%重心速度
	segdat.cgA          = cgA;                  %重心加速度
    segdat.seganV_GCS	= seganV_GCS;			%セグメント角速度(GCS)
	segdat.seganA_GCS   = seganA_GCS;			%セグメント角加速度(GCS)
	segdat.seganV_LCS	= seganV_LCS;			%セグメント角速度(LCS)
    segdat.I_LCS        = I_LCS;                %慣性主軸に一致する慣性テンソル
    segdat.I_GCS        = I_GCS;                %慣性主軸に一致しない軸まわりの慣性テンソル
	segdat.L            = L; 					%角運動量
	segdat.N            = N;         			%角運動量の微分
    segdat.mg           = mg;                   %重力
    segdat.ma           = ma;                   %運動方程式の左辺
    segdat.Krot         = Krot;                 %回転のエネルギー
    segdat.Ktra         = Ktra;                 %並進のエネルギー
    segdat.U            = U;                    %位置エネルギー
    segdat.E            = E;                    %全エネルギー           

end

