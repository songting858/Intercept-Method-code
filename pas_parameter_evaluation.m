% Test the goodness of fitting for the parameters surface area and leak
% conductance by comparing the predicted voltage trace using the point neuron 
%model and the real voltage trace 

close all;
clear;
clc;

V_rest=-70;

data=load('pas_parameter_neuron.dat');
dt=0.1; 

%estimated in pas_parameter_measure.m
gl=0.1; 
S=1.469e-4;


data=data-V_rest;

tstop=1000;

c='rgbmc';
t=0:dt:tstop;

v_pre(1)=0; %predicted voltage

for j=1:5
    I=0.01*j*10^-3;  %current amplitude set up in pas_parameter_measure.hoc
    v=data(j,1:end-1);
    plot(t,v,c(j));
    
    %current clamp on period
    for i =1:500/dt
        v_pre(i+1)=v_pre(i)-(gl*v_pre(i)-I/S)*dt;
    end
    
    %current clamp off period
    for i = 500/dt+1:1000/dt
        v_pre(i+1)=v_pre(i)-gl*v_pre(i)*dt;
    end
    hold on;
    plot(t,v_pre,['--',c(j)]);
end

xlabel('Time (ms)','Fontsize',16);
ylabel('Voltage (mV)','Fontsize',16);
set(gca,'Fontsize',16);

    


    
    
    
    
    
    