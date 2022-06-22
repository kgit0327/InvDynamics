function StickPicture(Action)

global Slider_Ifr Text_Ifr Slider_PBS Text_PBS ...
        dat FP cgdat VPause ...
        VSliderPBS Ifr PBS fr az el IRep F %#ok<NUSED>

switch Action
    case 'Start', IRep = 0; Plot_Continual; 
    case 'Pause', VPause = 1; Plot_Ifr;
    case 'SliderFN', VPause = 1; Plot_Ifr;
    case 'SliderPBS', VSliderPBS = 1;
    case 'Rec', Ifr = 1; PBS = 0.05; VPause = 1; Rec;    
    case 'Exit', VPause = 1; Exit;
    
end

end

function Plot_Continual

global Slider_Ifr Text_Ifr Slider_PBS Text_PBS ...
        dat FP cgdat VPause...
        VSliderPBS Ifr PBS fr az el IRep

VPause = 0; VSliderPBS = 0;

[az,el] = view;

Rep = 2; %繰り返し再生回数

Ifr = 1;

%Tin再生するフレーム数の行列、TinをRep回繰り返す
if PBS <= 0
Tin = [Ifr:fr 1:Ifr-1]; %途中から再生可能
else
Tin = [Ifr: round(10*PBS): fr-1  fr   1: round(10*PBS): Ifr-1];
end
TM = reshape(Tin(ones(1,Rep+1),:)',1,[]);


LM = [1 2; 1 3; 2 3; ...%右手
      2 4; 3 5; 4 5; ...%右前腕
      5 6; 5 7; 5 8; 4 7; 6 7; 7 8; 6 8; ...%右上腕
      17 18; 17 19; 18 20; 19 20; 20 21; 20 22; ...%右足
      21 23; 22 24; 23 24; ...%右下肢
      23 25; 24 25; ...%右大腿
      9 10; 9 11; 10 11; ...%左手　25番目～
      10 12; 11 13; 12 13; ...%左前腕
      13 14; 13 15; 13 16; 12 15; 14 15; 15 16;14 16; ...%左上腕
      26 27; 26 28; 27 29; 28 29; 29 30; 29 31; ...%左足
      30 32; 31 33; 32 33; ...%左下肢
      32 34; 33 34; ...%左大腿
      35 36; 35 37; 36 37; ...%頭部　49番目～
      6 38; 14 38; 8 39; 16 39; 38 42; 39 43; 6 40; 8 40; 14 41; ...
      16 41; 25 44; 25 46; 34 45; 34 47; 25 40; 34 41; 38 39; ...
      40 42; 40 43; 41 42; 41 43; 44 45; 46 47; 44 46; 45 47; 25 34;...
      42 44; 42 45; 43 46; 43 47];  %体幹
  
%C7とJNの中点
MP = (dat(:,3*38-2:3*38)+dat(:,3*39-2:3*39))./2;


% マーカーをoでプロットし、線で結ぶ

%   右　赤で表示
for ifr = TM
       
       hold on
       axis([-2 2 -2 2 0 4]);
       axis manual  
       view(az,el)
       
    for N = 1:24
           line('XData',[dat(ifr,3*LM(N,1)-2) dat(ifr,3*LM(N,2)-2)],...
                'YData',[dat(ifr,3*LM(N,1)-1) dat(ifr,3*LM(N,2)-1)],...
                'ZData',[dat(ifr,3*LM(N,1))    dat(ifr,3*LM(N,2))   ],...
                'Color','k','LineWidth',1.5)
    end
    
%   左　青で表示
    for N = 25:48
           line('XData',[dat(ifr,3*LM(N,1)-2) dat(ifr,3*LM(N,2)-2)],...
                'YData',[dat(ifr,3*LM(N,1)-1) dat(ifr,3*LM(N,2)-1)],...
                'ZData',[dat(ifr,3*LM(N,1))    dat(ifr,3*LM(N,2))   ],...
                'Color','k','LineWidth',1.5)
    end
    
%   中　緑で表示
    for N = 49:81
           line('XData',[dat(ifr,3*LM(N,1)-2) dat(ifr,3*LM(N,2)-2)],...
                'YData',[dat(ifr,3*LM(N,1)-1) dat(ifr,3*LM(N,2)-1)],...
                'ZData',[dat(ifr,3*LM(N,1))    dat(ifr,3*LM(N,2))   ],...
                'Color','k','LineWidth',1.5)
    end

%   頭と首の付け根　緑で表示 
    for N = 35:37
          line('XData',[dat(ifr,3*N-2) MP(ifr,1)],...
                'YData',[dat(ifr,3*N-1) MP(ifr,2)],...
                'ZData',[dat(ifr,3*N)   MP(ifr,3) ],...
                'Color','k','LineWidth',1.5)
    end
    
    
%   COM　黒で表示    
    plot3(cgdat(16).cg(1,ifr),cgdat(16).cg(2,ifr),cgdat(16).cg(3,ifr),'ro','MarkerFaceColor','r','MarkerSize',7)
    
    
%   フォース　赤で表示    
    quiver3(FP(1).cop(1,ifr),FP(1).cop(2,ifr),FP(1).cop(3,ifr),...
            FP(1).grf(1,ifr)/1000,FP(1).grf(2,ifr)/1000,FP(1).grf(3,ifr)/1000,...
            'r','LineWidth',2,'AutoScale','off','MaxHeadSize',0.3)
        
    quiver3(FP(2).cop(1,ifr),FP(2).cop(2,ifr),FP(2).cop(3,ifr),...
            FP(2).grf(1,ifr)/1000,FP(2).grf(2,ifr)/1000,FP(2).grf(3,ifr)/1000,...
            'r','LineWidth',2,'AutoScale','off','MaxHeadSize',0.3)
       
    if PBS <= 0
        pause(-PBS*0.05)
    end
    
    drawnow
    
    Ifr = ifr;
    
    set(Slider_Ifr,'Value',Ifr);
    set(Text_Ifr,'String',num2str(Ifr));
    
    if ifr == fr
        IRep = IRep+1;
    end
    
    if IRep >= Rep
        break
    end
          
    if VSliderPBS == 1
       Ifr = ifr;
       set(Slider_PBS,'Value',PBS);
       set(Text_PBS,'String',num2str(PBS)); break
    end
        
        
    if VPause == 1
        Ifr = ifr; break
    end
   
    [az,el] = view; hold off
    plot (0,0);
    axis([-2 2 -2 2 0 4]);
    view(az,el)
    axis off
    set(gcf,'Color',[1,1,1])
  
end
        PBS = eval('PBS'); 
end
   
function Rec

global Slider_Ifr Text_Ifr Slider_PBS Text_PBS ...
        dat FP cgdat Ifr PBS fr az el F

set(Slider_Ifr,'Value',Ifr);
set(Text_Ifr,'String',num2str(Ifr));    
set(Slider_PBS,'Value',PBS);
set(Text_PBS,'String',num2str(PBS));
    

[az,el] = view;
        
%TM再生するフレーム数の行列、TMをRep回繰り返す
TM = [1: round(10*PBS): fr-1  fr];


LM = [1 2; 1 3; 2 3; ...%右手
      2 4; 3 5; 4 5; ...%右前腕
      5 6; 5 7; 5 8; 4 7; 6 7; 7 8; 6 8; ...%右上腕
      17 18; 17 19; 18 20; 19 20; 20 21; 20 22; ...%右足
      21 23; 22 24; 23 24; ...%右下肢
      23 25; 24 25; ...%右大腿
      9 10; 9 11; 10 11; ...%左手　25番目～
      10 12; 11 13; 12 13; ...%左前腕
      13 14; 13 15; 13 16; 12 15; 14 15; 15 16;14 16; ...%左上腕
      26 27; 26 28; 27 29; 28 29; 29 30; 29 31; ...%左足
      30 32; 31 33; 32 33; ...%左下肢
      32 34; 33 34; ...%左大腿
      35 36; 35 37; 36 37; ...%頭部　49番目～
      6 38; 14 38; 8 39; 16 39; 38 42; 39 43; 6 40; 8 40; 14 41; ...
      16 41; 25 44; 25 46; 34 45; 34 47; 25 40; 34 41; 38 39; ...
      40 42; 40 43; 41 42; 41 43; 44 45; 46 47; 44 46; 45 47;25 34;...
      42 44; 42 45; 43 46; 43 47];  %体幹
 
  
%C7とJNの中点
MP = (dat(:,3*38-2:3*38)+dat(:,3*39-2:3*39))./2;

% マーカーをoでプロットし、線で結ぶ

clear F
F(1:length(TM)) = struct('cdata', [], 'colormap', []);
for FrN = 1:length(TM)
    ifr = TM(1,FrN);
       
       hold on
       axis([-2 2 -2 2 0 4]);
       axis manual  
       view(az,el)
       
 %   右　赤で表示      
    for N = 1:24
           line('XData',[dat(ifr,3*LM(N,1)-2) dat(ifr,3*LM(N,2)-2)],...
                'YData',[dat(ifr,3*LM(N,1)-1) dat(ifr,3*LM(N,2)-1)],...
                'ZData',[dat(ifr,3*LM(N,1))    dat(ifr,3*LM(N,2))   ],...
                'Color','k','LineWidth',1.5)
    end
    
%   左　青で表示
    for N = 25:48
           line('XData',[dat(ifr,3*LM(N,1)-2) dat(ifr,3*LM(N,2)-2)],...
                'YData',[dat(ifr,3*LM(N,1)-1) dat(ifr,3*LM(N,2)-1)],...
                'ZData',[dat(ifr,3*LM(N,1))    dat(ifr,3*LM(N,2))   ],...
                'Color','k','LineWidth',1.5)
    end
    
%   中　緑で表示
    for N = 49:81
           line('XData',[dat(ifr,3*LM(N,1)-2) dat(ifr,3*LM(N,2)-2)],...
                'YData',[dat(ifr,3*LM(N,1)-1) dat(ifr,3*LM(N,2)-1)],...
                'ZData',[dat(ifr,3*LM(N,1))    dat(ifr,3*LM(N,2))   ],...
                'Color','k','LineWidth',1.5)
    end

%   頭と首の付け根　緑で表示 
    for N = 35:37
          line('XData',[dat(ifr,3*N-2) MP(ifr,1)],...
               'YData',[dat(ifr,3*N-1) MP(ifr,2)],...
               'ZData',[dat(ifr,3*N)   MP(ifr,3) ],...
               'Color','k','LineWidth',1.5)
    end
    
    
%   COM　黒で表示    
    plot3(cgdat(16).cg(1,ifr),cgdat(16).cg(2,ifr),cgdat(16).cg(3,ifr),'ro','MarkerFaceColor','r','MarkerSize',7)
    
    
%   フォース　赤で表示    
    quiver3(FP(1).cop(1,ifr),FP(1).cop(2,ifr),FP(1).cop(3,ifr),...
            FP(1).grf(1,ifr)/1000,FP(1).grf(2,ifr)/1000,FP(1).grf(3,ifr)/1000,...
            'r','LineWidth',2,'AutoScale','off','MaxHeadSize',0.3)
        
    quiver3(FP(2).cop(1,ifr),FP(2).cop(2,ifr),FP(2).cop(3,ifr),...
            FP(2).grf(1,ifr)/1000,FP(2).grf(2,ifr)/1000,FP(2).grf(3,ifr)/1000,...
            'r','LineWidth',2,'AutoScale','off','MaxHeadSize',0.3)
    
    F(FrN) = getframe(gca);
    Ifr = ifr;
              
   
    [az,el] = view; hold off
    plot(0,0);
    axis([-2 2 -2 2 0 4]);
    view(az,el)
    axis off
    set(gcf,'Color',[1,1,1])
  
end

    movie2avi (F, ['Name' '.avi'], 'compression', 'None');
    
end
        
function Plot_Ifr

global dat FP cgdat Ifr az el

[az,el] = view; 

LM = [1 2; 1 3; 2 3; ...%右手
      2 4; 3 5; 4 5; ...%右前腕
      5 6; 5 7; 5 8; 4 7; 6 7; 7 8; 6 8; ...%右上腕
      17 18; 17 19; 18 20; 19 20; 20 21; 20 22; ...%右足
      21 23; 22 24; 23 24; ...%右下肢
      23 25; 24 25; ...%右大腿
      9 10; 9 11; 10 11; ...%左手　25番目～
      10 12; 11 13; 12 13; ...%左前腕
      13 14; 13 15; 13 16; 12 15; 14 15; 15 16;14 16; ...%左上腕
      26 27; 26 28; 27 29; 28 29; 29 30; 29 31; ...%左足
      30 32; 31 33; 32 33; ...%左下肢
      32 34; 33 34; ...%左大腿
      35 36; 35 37; 36 37; ...%頭部　49番目～
      6 38; 14 38; 8 39; 16 39; 38 42; 39 43; 6 40; 8 40; 14 41; ...
      16 41; 25 44; 25 46; 34 45; 34 47; 25 40; 34 41; 38 39; ...
      40 42; 40 43; 41 42; 41 43; 44 45; 46 47; 44 46; 45 47;25 34;...
      42 44; 42 45; 43 46; 43 47];  %体幹];  %体幹
 

%C7とJNの中点
MP = (dat(:,3*38-2:3*38)+dat(:,3*39-2:3*39))./2;
 
  hold off
  plot (0,0);
  hold on
  
       
    for N = 1:24
           line('XData',[dat(Ifr,3*LM(N,1)-2) dat(Ifr,3*LM(N,2)-2)],...
                'YData',[dat(Ifr,3*LM(N,1)-1) dat(Ifr,3*LM(N,2)-1)],...
                'ZData',[dat(Ifr,3*LM(N,1))    dat(Ifr,3*LM(N,2))   ],...
                'Color','k','LineWidth',1.5)
    end
    
%   左　青で表示
    for N = 25:48
           line('XData',[dat(Ifr,3*LM(N,1)-2) dat(Ifr,3*LM(N,2)-2)],...
                'YData',[dat(Ifr,3*LM(N,1)-1) dat(Ifr,3*LM(N,2)-1)],...
                'ZData',[dat(Ifr,3*LM(N,1))    dat(Ifr,3*LM(N,2))   ],...
                'Color','k','LineWidth',1.5)
    end
    
%   中　緑で表示
    for N = 49:81
           line('XData',[dat(Ifr,3*LM(N,1)-2) dat(Ifr,3*LM(N,2)-2)],...
                'YData',[dat(Ifr,3*LM(N,1)-1) dat(Ifr,3*LM(N,2)-1)],...
                'ZData',[dat(Ifr,3*LM(N,1))    dat(Ifr,3*LM(N,2))   ],...
                'Color','k','LineWidth',1.5)
    end

%   頭と首の付け根　緑で表示 
    for N = 35:37
          line('XData',[dat(Ifr,3*N-2) MP(Ifr,1)],...
                'YData',[dat(Ifr,3*N-1) MP(Ifr,2)],...
                'ZData',[dat(Ifr,3*N)   MP(Ifr,3) ],...
                'Color','k','LineWidth',1.5)
    end


%   COM　黒で表示    
     plot3(cgdat(16).cg(1,Ifr),cgdat(16).cg(2,Ifr),cgdat(16).cg(3,Ifr),'ko','MarkerFaceColor','k','MarkerSize',7)
    
%   フォース　赤で表示    
    quiver3(FP(1).cop(1,Ifr),FP(1).cop(2,Ifr),FP(1).cop(3,Ifr),...
            FP(1).grf(1,Ifr)/1000,FP(1).grf(2,Ifr)/1000,FP(1).grf(3,Ifr)/1000,...
            'r','LineWidth',2,'AutoScale','off','MaxHeadSize',0.3)
    quiver3(FP(2).cop(1,Ifr),FP(2).cop(2,Ifr),FP(2).cop(3,Ifr),...
            FP(2).grf(1,Ifr)/1000,FP(2).grf(2,Ifr)/1000,FP(2).grf(3,Ifr)/1000,...
            'r','LineWidth',2,'AutoScale','off','MaxHeadSize',0.3)
  
    axis([-2 2 -2 2 0 4]);
    plot (0,0)
    view(az,el)
    axis off
    set(gcf,'Color',[1,1,1])
end
          
function Exit
        close(gcf);
end