%------------ main routine
%--------------SPIMo------------------------------------------------------------
Z1=R1+j.*X1;                                   % Primary Winding Impedance
aZ1=abs(Z1);
%--------------------------------------------------------------------------
Zpi=(R2p./S)+j.*X2p;                        % inf Z +
Zni=(R2p./(2-S))+j.*X2p;                    % inf Z -
%------------------------------------------------------------------------
Zps1r=R2p./S;                         % + part 
Zps1x=j.*X2p;
Zps1z=Zps1r+Zps1x; 
Zps2x=j.*Xm;                          % parrallel Excitation inductance
Zps=Zps1z.* Zps2x;                 
Zpm=Zps1z+Zps2x;                      % j.*(X2p+Xm);
Zp=Zps./Zpm;                          %+P impedance  if inf Z+   =(R2p./S)+j.*X2p
Rp=real(Zp);
Xp=imag(Zp);
aZp=abs(Zp);
tZp=atan(Xp./Rp);                     % Degree
thZp=atan(Xp./Rp).*rDeg;              % angle conversion
%--------------------------------------------------------------------------
Zns1r=R2p./(2-S);                         % - part 
Zns1x=j.*X2p;
Zns1z=Zns1r+Zns1x; 
Zns2x=j.*Xm;                          % parrallel Excitation inductance
Zns=Zns1z.* Zns2x;                 
Znm=Zns1z+Zns2x;                      % j.*(X2p+Xm);
Zn=Zns./Znm;                          %+n impedance  if inf Z+   Zni=(R2p./(2-S))+j.*X2p; 
Rn=real(Zn);
Xn=imag(Zn);
aZn=abs(Zn);
tZn=atan(Xn./Rn);                     % Degree
thZn=atan(Xn./Rn).*rDeg;              % angle conversion
%--------------------------------------------------------------------------
Zt=Z1+Zp+Zn;
Rt=real(Zt);
Xt=imag(Zt);
aZt=abs(Zt);
tZt=atan(Xt./Rt);
thZt=atan(Xt./Rt)*rDeg;
%-----iron loss---------------------------------------------------
Ahi=A3.*Rt;            %A3=0.0000005
Phi=Ahi.*PmR;
Rhi=(V1.*V1)./Phi;    %SPIMo insert
%------------------------------------------------------------------------
Ztc=(Zt.*Rhi)./(Zt+Rhi);
Rtc=real(Ztc);
Xtc=imag(Ztc);
aZtc=abs(Ztc);
tZtc=atan(Xtc./Rtc);
thZtc=atan(Xtc./Rtc)*rDeg;
%------------------------------------------------------------------------
%------------------------------------------------------------------------
aV1=abs(V1);                              % + Phase
                                % serial Z
I1=V1./Zt+V1./Rhi;
aI1=abs(I1);
E1=(I1-V1./Rhi).*Z1;
aE1=abs(E1);
Ep=(I1-V1./Rhi).*Zp;
aEp=abs(Ep);
En=(I1-V1./Rhi).*Zn;
aEn=abs(Zn);
Et=E1+Ep+En;                               % Total Voltage
aEt=abs(Et);
%------------------------------------------------------------------------
                                           % I3= +, I5= - % Current Calculation
I3pr=Ep./Zps1z;                               
aI3pr=abs(I3pr);
I3px=Ep./Zps2x;                               
aI3px=abs(I3px);
I3= I3pr+I3px;
aI3=abs(I3);
%------------------------------------------------------------------------
I5nr=En./Zns1z;
aI5nr=abs(I5nr);
I5nx=En./Zns2x;
aI5nx=abs(I5nx);
I5= I5nr+I5nx;
aI5=abs(I5);
%------------------------------------------------------------------------
I2pp=aI3pr;   I2np=aI5nr;                   % sub data
%------------------------------------------------------------------------
PF1=real(I1)./abs(I1);
rPF1=PF1.*rDeg;
cosPh1=Rtc./aZtc;                             %sub data   cosPh1= Ie./It
rcosPh1=cosPh1.*rDeg;
%----------------% Mech Loss-----------------------------------------
Tp=I3.*I3.*Rp;                              % Torque Calculation
aTp=abs(Tp);
Tn=I5.*I5.*Rn;     
aTn=abs(Tn);
Tm=Tp-Tn;
aTm=aTp-aTn;
Plos=A3.*aTm;  % Mech Loss
To=aTm-Plos;   %[W]
%------------------------------------------------------------------------
Pm=aTm.*(1-S);                              % Power Calculation
Po=To.*(1-S);    %  -plos
P1=V1.*I1.*PF1;
aPm1=abs(Pm);
aP1=abs(P1);
aPo=abs(Po);
aPo1=aTm.*(1-S)-Plos;
%------------------------------------------------------------------------
%------------------------------------------------------------------------
Ef1=aPo1./aP1;
L=(1-Ef1)./Ef1;
AmR=0.9.*PmR;
LmR=PmR.*L;
TmR=LmR+aPo;
%---------------------------------------------------------
%E-JOIN
Xk=0.001;               % Kwh<- W
Xx=10;
Xs=(1./2).*(Xx.*(Xx+1));  % ���հ�
Mi=0.033;               % �� ��� ���� ��·�
Mc=0.0375;              % ����� �ݱݸ�
Mf=10;                  % ���� ��� ����
Me=101.57;              % ���� �Ǹ� �ܰ� [\/Kwh]
Mm=72000;               % ���� ����
Ma=0.9;                 % ���� �� �����󰢷�
Ty=4274;                % �� ��� �ð�
Um=0.8;                 % �� �̿��
Am=Mm./26.7;            % Am:  ���� ��ȭ
Bm=L.*aPo;              % Bm:  �ս����·� 
Aw=Am.*Xm.*(1+Mc).*Mf.*Ma;         % Aw:  ����� ȯ�귮
Bw=Bm.*Me.*Um.*Ty.*Xk.*Xx;  % Bw:  ���º�� ȯ�귮 Xx=
Cw=Bw./Aw;