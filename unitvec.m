function UV = unitvec(V)
% UNITVECTOR �x�N�g���̒P�ʃx�N�g�����B
% error(nargchk(1, 1, nargin));
% if ~isreal(V) error('�x�N�g���������z��ł��邩�m�F���Ă�������'); end;

VS = ones(length(V(:,1)),1)*sqrt(sum(V.*V));
UV = V./VS;