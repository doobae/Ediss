%-- 7/12/05  1:54 PM --%
%Dr Pro_0712 V1=110 SIM Chun pp420+ Park pp540
%-- 7/23/05  9:50 AM --%
%Program Sim Solver 2005.08.18 ->2006.01.05 end
%Xm 3%+ for Single Phase Induction Motor by Y.H.KIM
%V.6.1----SPIMo---S_dR0913--------------------------------------------
close all
clear all
N=0; Rhi=0; A0p=72000;  Xm=0.1;   Xm0=15; R2i=5;  XR=1.03;  xf=50;
A0=A0p./Xm; A1=0.001;   A2=0.00001;  A3=0.000001;  Aa1=0.05;
%A0, A1, A2  A1=0.07235; 0.15, 0.27
%B0=         B1=      B2=     
%C0=         C1=      C2=
oEf1=0;   oL=0;  %dEf1 *****
R2dd=-0.00005;   R2pf=10;
                  dRad=pi./180;
                  rDeg=180./pi;             
  fid = fopen('SIM_hp1.txt','w');
  fprintf(fid,'SIM_hp1.txt    ,Xm,  aPo1,   dL,   L,   R2p,  aI1, Ef1, dEf1\n');
  fprintf(fid,'*******************************************************************************************************************************************************************  \n');
  %Solver Start
S=0.05;
HP=.5;
P=4;
f=60;
R1=1.86;       %0.00001;   %
X1=2.56;       %0.00001;   %
X2p=1.28;      %0.00001;   %
%R2p=1.161./2;
Pmec=13.5;
PmR=746.*HP;  
V1=110;      
%--------------------------------------------------------------------------
R2f=(S.*(2-S).*(1-S).*(1-S).*V1.*V1)./(2.*PmR);
%%Xmf=(R2f./S).*.3;    %ref Xm
Xmf=Xm0.*(1./XR);
% to Xm  15-70
%--------------------------------------------------------------------------
Ima=V1./((R2f./S)+(R2f./(2-S)));
Pim=V1.*Ima;
Pom=(Ima.*Ima).*(R2f./S);
Efm=Pom./Pim;
%param cal
%--------------------------------------------------------------------------
%Plos=A1.*PmR;  % Mech Loss
Phi=A2.*PmR;
Rhi=(V1.*V1)./Phi;
%---------------------------------------------
   Xs=Xmf;
for x=1:+1:xf,
    OR2p=0;  dEf1=0;  dL=0;   %dEf1 *****
    Xm=Xs;  
    Xm=Xm.*XR;
    % routine 
 R2pf=10; R2d=-.002;
    for R2p=R2f:R2d:0.01, 
                  M=Xm./R2p;                   % inverse
%--------------------------------------------------------------------------
%S=(0.01:.001:.99)';
%M=(0.01:.01:0.09)';
%R2p=M.*Xm;
%  Graph Scale Mode Start
                                               % Graph Scale Mode End
%--------------------------------------------------------------------------
SPIMo
% graph plot   
%------------------------------------------------------------------------
Ef1max=max(Ef1);% Maximum Eff
Efd=Ef1max-Ef1;
 aTmmax=max(aTm);
 aPm1m=max(aPm1);
 aTm1k=aTm.*0.001;
 aPm1k=aPm1.*0.001; 
 To1k=To.*0.001;                              
 Po1k=Po.*0.001;
 K=abs(aPo-PmR);

 dXm=Ef1./Xm;
  %------------------------------------------------------------------------
S_d_R0913
 %*------------------------------------------------------------------------
  fid = fopen('SIM_hp1.txt','a');
 % fprintf(fid, '     M                     Xm                  dXm                   Pmk                PF1               Ef1   SIM_1.txt\n');
   %*------------------------------------------------------------------------
 if AmR <= aPo1
S_d_R0913
      R2d=R2dd;
   if PmR <= aPo1
       OR2p=R2p;  R2d=R2dd;
S_d_R0913
     for R2p=R2p:R2dd:0.001, 
       SPIMo
S_d_R0913
       if OR2p <= R2p  
           R2p=OR2p;  R2d=R2d;
disp('**********************************************************');
S_d_R0913
disp('**********************************************************');          
%new Version   2006.01.11
          %---------------proceed  0901
           N=N+1;    dEf1=oEf1-Ef1;   dL=oL-L;   %dEf1 ***** %oEf1 *****
fprintf(fid,'%13.3f         %13.3f        %13.3f          %13.3f          %13.3f          %13.3f        %13.3f        %9.6f\n',Xm,  aPo1,   dL,   L,   R2p,  aI1, Ef1, dEf1);
       OR2p=R2p; 
       oEf1=Ef1;   oL=L;   %dEf1 *****
S_d_R0913
    %   fclose(fid);
      %    plot(X,aTmk,'k',X,aPm1k,'B',X,Ef1,'G',X,R2p,'R',X,K);
          break
         % return 
     end  
     break
      end  %for 
    end
  end
end
% plot(X,aTmk,'k',X,aPm1k,'B',X,Ef1,'G',X,R2p,'R',X,K);
% plot(S,aTm,'k',S,aTp,'B',S,-aTn,'R',S,Ef1g,'G',S,To,S,PF1g,S,Op1);
%plot(X,aI1,'k',X,aI2pr,X,aI2nr);  XLABEL('Y=R2/Xm, X=Y*100 [%] '); YLABEL('T(Black)2 :Tf(Blue)1:Tb(Green)3');
%plot(X,aTm,'k',X,aTp,X,aTn);  XLABEL('Y=R2/Xm, X=Y*100 [%] '); YLABEL('T(Black)2 :Tf(Blue)1:Tb(Green)3');
%plot(X,Ef1,'k',X,cosPh1,'G',X,Tok,'B',X,Pok,'R'); XLABEL('X, X=(Xm./R2p)*100 [%],R2p ref.=6.7[%]'); YLABEL('Eff(Black): cosPh1,To(Blue),Po ');
%plot(X,Ef1g,'k',X,aTm,'B',X,R2p,'R'); XLABEL('Ym=Xm/R2p, X=(26.7/1,78)*100 [%]'); YLABEL('Eff(Black)[%]: aTm (Blue)[W], Cos Ph1 (RED) Curve');
%GRID
 %fprintf(fid,'%13.3e          %13.3e          %13.3e
 %%13.3f\n',Xm,  aPm1,  cosPh1, Ef1);
  %------------------------------------------------------------------------            
R2d=R2d;
  S_d_R0913
    %routine end
    Xs=Xm;
   end
   %end
%---------------------------------------------------------
% plot mode
 plot(Xm,Aw,'k',Xm,Bw,'B',Xm,Cw,'R');
%---------------------------------------------------------
%plot(X,aTm1k,'k',X,aPm1k,'B',X,Ef1,'G',X,R2p,'R',X,K);
fclose(fid);