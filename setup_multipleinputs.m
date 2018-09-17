% generate multiple input locations for the case of multiple inputs

NE=20*100; %total number of E inputs
NI=5*100;  %total number of I inputs

E_location=[7,11,19,24,31,35,29,42,48,124,65,77,78,108,110,130,134,112,91,118];
E_loc=[];

for i = 1:100
    E_loc=[E_loc,E_location];
end

I_location=[74,84,90,92,98];
I_loc=[];

for i = 1:100
    I_loc=[I_loc,I_location];
end

if length(E_loc)~=NE
    disp('excitatory input location number is incorrect!');
    return;
end

if length(I_loc)~=NI
    disp('inhibitory input location number is incorrect!');
    return;
end

Loc_list=[E_loc';I_loc'];
t_end=1000;
T_list=rand(NE+NI,1)*t_end;

list=[Loc_list;T_list];
save input_location_time.dat list -ascii


