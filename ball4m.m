function [ballc,r] = ball4m(n)

% ë∫ìcÇ∆ì°à‰, ëÃàÁäwå§ãÜ, 2014 éQè∆

ball1 = n.ball1;
ball2 = n.ball2;
ball3 = n.ball3;
ball4 = n.ball4;
[~,nFr] = size(ball1);
       
for iFr = 1:nFr
      
    ball1x(:,iFr) = ball1(1,iFr); ball1y(:,iFr) = ball1(2,iFr); ball1z(:,iFr) = ball1(3,iFr);
    ball2x(:,iFr) = ball2(1,iFr); ball2y(:,iFr) = ball2(2,iFr); ball2z(:,iFr) = ball2(3,iFr);
    ball3x(:,iFr) = ball3(1,iFr); ball3y(:,iFr) = ball3(2,iFr); ball3z(:,iFr) = ball3(3,iFr);
    ball4x(:,iFr) = ball4(1,iFr); ball4y(:,iFr) = ball4(2,iFr); ball4z(:,iFr) = ball4(3,iFr);
 
    xmatrix(:,iFr) = [ball1x(:,iFr);ball2x(:,iFr);ball3x(:,iFr);ball4x(:,iFr)];
    ymatrix(:,iFr) = [ball1y(:,iFr);ball2y(:,iFr);ball3y(:,iFr);ball4y(:,iFr)];
    zmatrix(:,iFr) = [ball1z(:,iFr);ball2z(:,iFr);ball3z(:,iFr);ball4z(:,iFr)];
    
    xi2(:,iFr) = sum(xmatrix(:,iFr).^2); xiyi(:,iFr) = sum(xmatrix(:,iFr).*ymatrix(:,iFr)); 
    xizi(:,iFr) = sum(xmatrix(:,iFr).*zmatrix(:,iFr)); xi(:,iFr) = sum(xmatrix(:,iFr));
    
    yi2(:,iFr) = sum(ymatrix(:,iFr).^2); yizi(:,iFr) = sum(ymatrix(:,iFr).*zmatrix(:,iFr));
    yi(:,iFr)=sum(ymatrix(:,iFr));
    
    zi2(:,iFr) = sum(zmatrix(:,iFr).^2); zi(:,iFr)=sum(zmatrix(:,iFr));
    
    xi3(:,iFr) = sum(xmatrix(:,iFr).^3); xiyi2(:,iFr) = sum(xmatrix(:,iFr).*(ymatrix(:,iFr).^2));
    xizi2(:,iFr) = sum(xmatrix(:,iFr).*(zmatrix(:,iFr).^2)); 
    
    xi2yi(:,iFr) = sum((xmatrix(:,iFr).^2).*ymatrix(:,iFr)); yi3(:,iFr) = sum(ymatrix(:,iFr).^3); 
    yizi2(:,iFr) = sum(ymatrix(:,iFr).*(zmatrix(:,iFr).^2));
    
    xi2zi(:,iFr) = sum((xmatrix(:,iFr).^2).*zmatrix(:,iFr)); yi2zi(:,iFr) = sum((ymatrix(:,iFr).^2).*zmatrix(:,iFr));
    zi3(:,iFr) = sum(zmatrix(:,iFr).^3);
    
    o = zeros(nFr);
    o(2:nFr,:) = [];
    o(:,iFr) = (4);
   
    
    a(:,(4*(iFr-1)+1:4*iFr)) = [xi2(:,iFr) xiyi(:,iFr) xizi(:,iFr) xi(:,iFr);...
                                xiyi(:,iFr) yi2(:,iFr) yizi(:,iFr) yi(:,iFr);...
                                xizi(:,iFr) yizi(:,iFr) zi2(:,iFr) zi(:,iFr);...
                                xi(:,iFr) yi(:,iFr) zi(:,iFr) o(:,iFr)];
   
    b(:,iFr) = [-(xi3(:,iFr)+xiyi2(:,iFr)+xizi2(:,iFr));-(xi2yi(:,iFr)+yi3(:,iFr)+yizi2(:,iFr));...
                -(xi2zi(:,iFr)+yi2zi(:,iFr)+zi3(:,iFr));-(xi2(:,iFr)+yi2(:,iFr)+zi2(:,iFr))];
          
    c(:,iFr) = a(:,(4*(iFr-1)+1:4*iFr))\b(:,iFr);
  
    
    A(:,iFr) = c(1,iFr);
    B(:,iFr) = c(2,iFr);
    C(:,iFr) = c(3,iFr);
    D(:,iFr) = c(4,iFr);
    
    x0(:,iFr) = -A(:,iFr)/2;
    y0(:,iFr) = -B(:,iFr)/2;
    z0(:,iFr) = -C(:,iFr)/2;
    
    r(:,iFr) = sqrt((x0(:,iFr).^2)+(y0(:,iFr).^2)+(z0(:,iFr).^2)-D(:,iFr));
    ballc(:,iFr) = [x0(:,iFr);y0(:,iFr);z0(:,iFr)];
    
end   
end

   