clear;
%close all;
clc;

dt=5e-2;       %ms
t=(0:2000)*dt; 

Vj=15;
Vr=-68;

VE=0-Vr-Vj;
VI_70=-70-Vr-Vj;
VI_80=-80-Vr-Vj;

load('conductance.mat');
load('SSC.mat');

V=-90:10:-50;
V=V'-Vj;

SSC_70(1,:)=SSC_vh90_rev70;
SSC_70(2,:)=SSC_vh80_rev70;
SSC_70(3,:)=SSC_vh70_rev70;
SSC_70(4,:)=SSC_vh60_rev70;
SSC_70(5,:)=SSC_vh50_rev70;

SSC_80(1,:)=SSC_vh90_rev80;
SSC_80(2,:)=SSC_vh80_rev80;
SSC_80(3,:)=SSC_vh70_rev80;
SSC_80(4,:)=SSC_vh60_rev80;
SSC_80(5,:)=SSC_vh50_rev80;

for i = 1:10:2001
    
    par_70=polyfit(V-Vr,SSC_70(:,i),1);
    b_70(i)=-par_70(2);
    k_70(i)=par_70(1);
   
    if i==201
        figure(2);
        subplot(2,2,2);
        v_range=V(1)-Vr-5:1:V(5)-Vr+5;
        par_700=polyfit(V-Vr,-SSC_70(:,i),1);
        z=polyval(par_700,v_range);
        plot(V-Vr,-SSC_70(:,i),'ro');
        hold on;
        plot(v_range,z,'r');
    end
    
    par_80=polyfit(V-Vr,SSC_80(:,i),1);
    b_80(i)=-par_80(2);
    k_80(i)=par_80(1);
        
    if i==201
        figure(2);
        subplot(2,2,2);
        v_range=V(1)-Vr-5:1:V(5)-Vr+5;
        par_800=polyfit(V-Vr,-SSC_80(:,i),1);
        z=polyval(par_800,v_range);
        plot(V-Vr,-SSC_80(:,i),'bs');
        hold on;
        plot(v_range,z,'b');
        xlabel('Voltage (mV)');
        ylabel('Current (pA)');
        set(gca,'xlim',[-45 10],'XTick',-45:15:10,'XTickLabel',{-45+15:15:10+15})
        ylim([0,120]);
        box off;
    end
    
end

s=110;   %sample rate
t_s=t(1:s:end);
GI_b=(b_70-b_80)/(VI_70-VI_80);
GE_b=(b_70-GI_b*VI_70)/VE;
GI_b=GI_b(1:s:end);
GE_b=GE_b(1:s:end);

GI_kb=(b_70-k_70*VE)/(VI_70-VE);
GE_kb=(k_70-GI_kb);
GI_kb=GI_kb(1:s:end);
GE_kb=GE_kb(1:s:end);

figure(2);
subplot(2,2,3);
plot(t_s,GE_b,'r.','Markersize',10);
hold on;
plot(t_s,GE_kb,'ro','Markersize',2);
hold on;
plot(t,GE_true,'r');
hold on;
plot(t_s,GI_b,'b.','Markersize',10);
hold on;
plot(t_s,GI_kb,'bo','Markersize',2);
hold on;
plot(t,GI_true,'b');
xlabel('Time (ms)');
ylabel('Conductance (nS)');
ylim([-0.1,2.2]);
box off;