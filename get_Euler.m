function  Seg_angle = get_Euler(R,nFr,nseg)

for iFr = 1:nFr
    
    for iseg = 1:nseg
        
        Seg_angle.an(iseg).y(:,iFr) = asin(R(iseg).mat(3*iFr,1));
        
        Seg_angle.an(iseg).x(:,iFr) = asin(-R(iseg).mat(3*iFr,2)/cos(Seg_angle.an(iseg).y(:,iFr)));
        
        if R(iseg).mat(3*(iFr-1)+1,1)/cos(Seg_angle.an(iseg).y(:,iFr)) <= 0.05 %Šp“x•â³
            Seg_angle.an(iseg).z(:,iFr) = acos(R(iseg).mat(3*(iFr-1)+1,1)/cos(Seg_angle.an(iseg).y(:,iFr)));
        else 
            Seg_angle.an(iseg).z(:,iFr) = asin((-R(iseg).mat(3*(iFr-1)+2,1)/cos(Seg_angle.an(iseg).y(:,iFr))));
        end
        
    end
    
end

end
