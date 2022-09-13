close all
clear all
N=0; 
Rhi=0; 
A0p=72000;  
Xm=0.1;   
Xm0=15; 
R2i=5;  
XR=1.005;  
xf=100;
A0=A0p./Xm; 
Anf=0.0000000001;
A1=0.001;   
A2=0.00001;  
A3=0.000001;  
Aa1=0.05;
oEf1=0;  oL=0;   %oEf1 *****
R2dd=-0.0001;   R2pf=10;
                  dRad=pi./180;
                  rDeg=180./pi;             
  fid = fopen('hp025_4274.txt','w');
  fprintf(fid,'N     Xm,          Ef1          dEf1,             L,          dL,               Aw,                   Bw                 Cw\n');
  fprintf(fid,'    *********************************************************************************************************************  \n');
  %Solver Start
S=0.05;
HP=0.25;
P=4;
f=60;
R1=1.86;       %0.00001;   %
X1=2.56;       %0.00001;   %
X2p=1.28;      %0.00001;   %
PmR=746.*HP;  
AmR=0.9.*PmR;
V1=110;      
%--------------------------------------------------------------------------
R2f=(S.*(2-S).*(1-S).*(1-S).*V1.*V1)./(2.*PmR);
Xmf=Xm0.*(1./XR);
%--------------------------------------------------------------------------
Ima=V1./((R2f./S)+(R2f./(2-S)));
Pim=V1.*Ima;
Pom=(Ima.*Ima).*(R2f./S);
Efm=Pom./Pim;
Phi=Anf.*PmR;
Rhi=(V1.*V1)./Phi;
%---------------------------------------------
Xk=0.001;               % Kwh<- W
Xx=10;
Mi=0.033;               % 연 평균 물가 상승률
Mc=0.0375;              % 연평균 콜금리
Mf=10;                  % 모터 평균 수명
Me=101.57;              % 전력 판매 단가 [\/Kwh]
Mm=72000;               % 모터 가격
Ma=0.9;                 % 모터 연 감가상각률
Ty=4274;                % 연 사용 시간
Um=0.8;                 % 연 이용률
%-------------------------------------------------------
   Xs=Xmf;
for x=1: +1: xf,
    Xm = Xs;  
    Xm = Xm.*XR;
    dEf1=0;  dL=0;   %dEf1 *****
    R2pf = 10; 
    R2d = -.0003;
    for R2p = R2f: R2d: 0.001, 
        M = Xm./R2p;                   % inverse
        SPIMo
        %fid = fopen('kys.txt','a');
        if AmR <= aPo1
            R2d = R2dd;
            if PmR <= aPo1
                N = N+1;  
                dEf1=oEf1-Ef1;   dL=oL-L;   %dEf1 ***** %oEf1 *****
                fprintf(fid,'%5.1f  %13.3f  %13.3f  %13.5f  %13.3f  %13.5f  %20.3f  %20.3f  %9.5f\n',N, Xm, Ef1,dEf1,  L, dL, Aw, Bw, Cw);
                oEf1=Ef1;   oL=L;   %dEf1 *****
                S_d_Kys
                break
            end
        end
    end
    Xs=Xm;
end
fclose(fid);




