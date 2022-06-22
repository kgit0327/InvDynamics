for icond2=1

FNM={'A'};

FN1=char(FNM(icond2,1));
    
FN2=char([FN1,'.avi']);

readerObj = VideoReader(FN2);
cd('./movie')
writerObj = VideoWriter(FN1, ...
                        'MPEG-4');

open(writerObj);

for k = 1:readerObj.NumberOfFrames
   img = read(readerObj,k);
   writeVideo(writerObj,img);
end

close(writerObj);

cd('../')

end