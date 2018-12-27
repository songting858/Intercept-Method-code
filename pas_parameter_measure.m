%process data generated from pas_parameter_measure.hoc
%to estimate the effective surface area 
%using a constant current injection at the soma for the first 500 ms

close all;
clear;
clc;

V_rest=-70;

data=load('pas_parameter_neuron.dat');
dt=0.1;
gl_default=0.07;  %determined by eyeball norm

data=data-V_rest; %shift the resting potential from -70mV to 0mV

tstop=1000;

c='rgbmc';
t=0:dt:tstop;

for j=1:5
    
    I=0.01*j*10^-3;  %unit transfered from nA to uA
    v=data(j,1:end-1);
    
    subplot(3,1,1);
    hold on;
    plot(t,v,c(j));

    v_inf=v(tstop/dt/2);
    dif_v=diff(v(tstop/dt/2:tstop/dt))/dt;
    dif_v=tsmovavg(dif_v,'s',round(0.5/dt));

    v_decay=v(tstop/dt/2:tstop/dt-1);
    half_t=(0:length(v_decay)-1)*dt+500;
    log_v=log(v_decay);
    
    subplot(3,1,2);
    hold on;
    plot(v_decay,dif_v,c(j));
    
    S(j)=I/v_inf/gl_default;  %effective surface area
    
    subplot(3,1,3);
    hold on;
    plot(half_t,log_v,c(j));
end

disp(['S=',num2str(mean(S))]);

subplot(3,1,1);
legend('0.01nA','0.02nA','0.03nA','0.04nA','0.05nA');
xlabel('Time (ms)','Fontsize',16);
ylabel('Voltage (mV)','Fontsize',16);
set(gca,'Fontsize',16);
    
subplot(3,1,2);
hold on;
x=linspace(0,9,1000);
plot(x,-gl_default*x,'--k');
legend('0.01nA','0.02nA','0.03nA','0.04nA','0.05nA');
xlim([0,4]);
set(gca,'Fontsize',16);
xlabel('Voltage (mV)','Fontsize',16);
ylabel('Voltage Derivative (mV)','Fontsize',16);
    
subplot(3,1,3);
hold on;
x=linspace(500,600,10000);
plot(x,-gl_default*x+26.5,'--k');
xlim([500,530]);
legend('0.01nA','0.02nA','0.03nA','0.04nA','0.05nA');
set(gca,'Fontsize',16);
xlabel('time (ms)','Fontsize',16);
ylabel('Log Voltage','Fontsize',16);
    
    
j=1:5;
current=0.01*j*10^-3*10^6;
voltage=data(j,tstop/dt/2)';
figure;
plot(current,voltage,'o','Markersize',12);
k=polyfit(current,voltage,1);
x=linspace(0,max(current)*1.1,1000);
hold on;
y=k(1)*0.985*x;
plot(x,y,'r','Linewidth',1);
ylim([0,Inf]);
xlabel('Current (pA)');
ylabel('Voltage (mV)');