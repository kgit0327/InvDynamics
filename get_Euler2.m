function Jnt_angle = get_Euler2(RJ,nFr,njnt)

for iFr = 1:nFr
    
    for ijnt = 1:njnt
        
        Jnt_angle.an(ijnt).y(:,iFr) = asin(RJ(ijnt).mat(3*iFr,1));
        
        if -RJ(ijnt).mat(3*iFr,2)/cos(Jnt_angle.an(ijnt).y(:,iFr)) >= 0.95
            Jnt_angle.an(ijnt).x(:,iFr) = acos(RJ(ijnt).mat(3*iFr,3)/cos(Jnt_angle.an(ijnt).y(:,iFr)));
        else
            Jnt_angle.an(ijnt).x(:,iFr) = asin(-RJ(ijnt).mat(3*iFr,2)/cos(Jnt_angle.an(ijnt).y(:,iFr)));
        end
        
        if RJ(ijnt).mat(3*(iFr-1)+1,1)/cos(Jnt_angle.an(ijnt).y(:,iFr)) <= 0.05
            Jnt_angle.an(ijnt).z(:,iFr) = acos(RJ(ijnt).mat(3*(iFr-1)+1,1)/cos(Jnt_angle.an(ijnt).y(:,iFr)));
        else  
            Jnt_angle.an(ijnt).z(:,iFr) = asin((-RJ(ijnt).mat(3*(iFr-1)+2,1)/cos(Jnt_angle.an(ijnt).y(:,iFr))));
        end
        
    end
    
end

end