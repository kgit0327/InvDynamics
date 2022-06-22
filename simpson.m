function P = simpson(dat,time_int)

[npoint,~] = size(dat);

for ipoint = 1:npoint
    
    P(ipoint,:) = (dat(ipoint,1)+dat(ipoint,end)+3*sum(dat(ipoint,2:3:end-2))+3*sum(dat(ipoint,3:3:end-1))+2*sum(dat(ipoint,4:3:end-3)))*(3*time_int)/8;

end

end