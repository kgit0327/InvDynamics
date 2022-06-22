function 	diff=dif5(dat,nFr,time_int)

[nP,~]=size(dat);

for iP=1:nP;
    
   diff(iP,1)=(-25*dat(iP,1)+48*dat(iP,2)-36*dat(iP,3)+16*dat(iP,4)-3*dat(iP,5))/(12*time_int);
    
   diff(iP,2)=(-3*dat(iP,1)-10*dat(iP,2)+18*dat(iP,3)-6*dat(iP,4)+1*dat(iP,5))/(12*time_int);
   for iFr=3:nFr-2
   diff(iP,iFr)=(dat(iP,iFr-2)-8*dat(iP,iFr-1)+8*dat(iP,iFr+1)-1*dat(iP,iFr+2))/(12*time_int);
   end
   diff(iP,nFr-1)=(-1*dat(iP,nFr-4)+6*dat(iP,nFr-3)-18*dat(iP,nFr-2)+10*dat(iP,nFr-1)+3*dat(iP,nFr))/(12*time_int);
   
   diff(iP,nFr)=(3*dat(iP,1)-16*dat(iP,2)+36*dat(iP,3)-48*dat(iP,4)+25*dat(iP,5))/(12*time_int);
       
end

	return;
