function UV = unitvec(V)
% UNITVECTOR ベクトルの単位ベクトル化。
% error(nargchk(1, 1, nargin));
% if ~isreal(V) error('ベクトルが実数配列であるか確認してください'); end;

VS = ones(length(V(:,1)),1)*sqrt(sum(V.*V));
UV = V./VS;