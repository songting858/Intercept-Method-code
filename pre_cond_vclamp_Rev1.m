%process data from pair_EI_VClamp_1.dat or multi_EI_VClamp_1.dat which corresponds to reversal potentials VE1 and VI1
%fit the I-V curves and record the slope and intercept in the variable g1
%(g1(1) is slope and g1(2) is the intercept)
%used in cond_estimate_vclamp.m

global dt;
global tstop;
global multi_input_case
global S;
global V_rest;

if multi_input_case==0
    data_origin=load('pair_EI_VClamp_1.dat');
    data=data_origin(:,195/dt+1:end);
else
    data_origin=load('multi_EI_VClamp_1.dat');
    data=data_origin(:,395/dt+1:end);
end

data(1:2:end,:)=data(1:2:end,:)-V_rest;

for i = 1:5
    vol(i,:)=data(3+2*i,1:end-1);
    cur(i,:)=data(4+2*i,1:end-1);
end

func1 =@(x,xdata) x(1)*xdata+x(2);
x0=zeros(1,2);

k=1;

for i = 1/dt:0.1/dt:tstop/dt-1
    
    for j = 1:5
        xdata(j)=vol(j,i); %(mV)
        ydata(j)=(cur(j,i)-cur(j,1))*10^-3/S; %(uA/cm^2)
    end
    
    g1(k,:) = lsqcurvefit(func1,x0,xdata,ydata);
    k=k+1;
end

g1=-g1(6:end,:);





