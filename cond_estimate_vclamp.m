close all;
clc;
clear;

global GL;  %leak conductance
global S;   %effective surface area 
global REV_E; %exictatory reversal potential relative to resting potential
global REV_I; %inhibitory reversal potential relative to resting potential
global V_rest; %resting potential
global dt; %simulation time step
global lag; %time lag to smooth conductance in the moving average approach
global tstop; %simulation time after synaptic inputs start
global multi_input_case; %indicator of single-input case or multi-input case

multi_input_case=1;

V_rest=-70;% (mV)
REV_E=70; %(mV)
REV_I=-10; %(mV)
dt=0.1; %(ms) 
lag=0.5; %(ms) 

%passive parameters are obtained from 
%pas_parameter_measure.hoc and pas_parameter_measure.m
GL=0.1;   %(mS/cm2) 
S=1.469e-4;  %(cm2)

%As an example, we change Rev_I from -10 mV to -20 mV relative to the
%resting potential -70 mV corresponding to the set in the NEURON code

VE1=REV_E;  
VI1=REV_I; 

VE2=REV_E;  
VI2=REV_I-10;

   
%===========calculating the reference E and I conductances=================
if multi_input_case==0
    tstop=100;
    data=load('pair_EI_VClamp_1.dat');
    data=data(:,195/dt+1:end); 
else 
    tstop=1000; 
    data=load('multi_EI_VClamp_1.dat');
    data=data(:,395/dt+1:end); 
end

data(1:2:end,:)=data(1:2:end,:)-V_rest;

GE=computeGE(data(1,1:end-1));
GI=computeGI(data(3,1:end-1));

t=linspace(-5,tstop,length(GE));


%==========calculating the E and I conductances using the IM method========

%fit the slope and intercept of the I-V relation at each time with two sets of reversal potentials

pre_cond_vclamp_Rev1();
pre_cond_vclamp_Rev2();

%estimate the conductance using the intercept method
if VI1==VI2
    GE_est_b=(g2(:,2)-g1(:,2))/(VE2-VE1);
    GI_est_b=(g2(:,2)-GE_est_b*VE2)/VI2;
else
    GI_est_b=(g2(:,2)-g1(:,2))/(VI2-VI1);
    GE_est_b=(g2(:,2)-GI_est_b*VI2)/VE2;
end

%==========calculating the E and I conductances using the SIM method=======
GE_est_kb=(g1(:,1)*VI1+g1(:,2))/(VE1-VI1);
GI_est_kb=-g1(:,1)-GE_est_kb;

%========================data postprocessing===============================

%downsample the data for plot
time_lag=50;
GE_est_pb=GE_est_b(1:time_lag:end);
GI_est_pb=GI_est_b(1:time_lag:end);

GE_est_pkb=GE_est_kb(1:time_lag:end);
GI_est_pkb=GI_est_kb(1:time_lag:end);

t2=linspace(-5,tstop,length(GE_est_pb));

%rescale the conductance data from density (mS/cm^2) to quantity (nS)
GE_est_pb=GE_est_pb*S*10^6;
GI_est_pb=GI_est_pb*S*10^6;
GE_est_pkb=GE_est_pkb*S*10^6;
GI_est_pkb=GI_est_pkb*S*10^6;
GE=GE*S*10^6;
GI=GI*S*10^6;

%=============================plot the result==============================
figure(1);
plot(t2,GE_est_pb,'ro','MarkerSize',6,'MarkerFaceColor','r');
hold on;
plot(t2,GI_est_pb,'bo','MarkerSize',6,'MarkerFaceColor','b');
hold on;
plot(t,GE,'-r','Linewidth',2);
hold on;
plot(t,GI,'-b','Linewidth',2);

plot(t2,GE_est_pkb,'ro','MarkerSize',6);
hold on;
plot(t2,GI_est_pkb,'bo','MarkerSize',6);

xlim([0,Inf]);
% ylim([-0.5,1.5]);
ylim([-0.5,4]);
xlabel('Time (ms)','Fontsize',16);
ylabel('Conductance (nS)','Fontsize',16);
set(gca,'Fontsize',16);
box off;

