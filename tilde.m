
%  ■　関数 tilde の定義
 
function OUT = tilde(A)

OUT = [0     -A(3) A(2);%
      A(3)      0 -A(1);%         歪対称行列を計算する関数
     -A(2)    A(1)   0];%        
