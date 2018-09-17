%first order difference scheme to compute excitatory conductance
function G_E = computeGE(Voltage)

global GL;
global REV_E;
global dt;
global lag;

V=Voltage';

dvdt=[diff(V)/dt;0];

G_E=(dvdt+GL*V)./(REV_E-V);

%smooth regularization
tempG_E=tsmovavg(G_E','s',round(lag/dt))';
G_E(round(lag/dt):length(G_E))=tempG_E(round(lag/dt):length(G_E));