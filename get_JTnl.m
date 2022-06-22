function JT_nl = get_JTnl(JT,FP,cgdat,time_int,njnt,nFr)

cg_zv = dif3(cgdat(16).cg(end,:),nFr,time_int);
start = find(cg_zv < -0.1, 1, 'first'); %重心が下向きに動き始めたコマ数を抽出
finish = find(FP(2).grf(3,:) == 0, 1, 'first'); %離地したコマ数を抽出

flame = finish - start; %規格化したい範囲のコマ数
Timeflame = (0:(time_int):flame*(time_int)); %規格化したい範囲の時間
  
MaxTf = max(Timeflame);
interTf = MaxTf/100; %規格化したい範囲を100コマにする際の1コマ当たりの時間
TimeCC = (0:interTf:MaxTf); %新しい時間軸 (0%～100%)
 
 npoint = 3*njnt;
 
 for ipoint = 1:npoint
     
     data(1,ipoint).p = JT(ipoint,:);
     ndata(ipoint,:) = interp1(Timeflame,data(1,ipoint).p(start:finish),TimeCC,'spline'); %3次スプライン補間
     
 end
 
 JT_nl = ndata;
 
end