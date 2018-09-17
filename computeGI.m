%first order difference scheme to compute inhibitory conductance
function G_I = computeGI(Voltage)

global GL;
global REV_I;
global dt;
global lag;

V=Voltage';


dvdt=[diff(V)/dt;0];

G_I=(dvdt+GL*V)./(REV_I-V);

%smooth regularization
 tempG_I=tsmovavg(G_I','s',round(lag/dt))';
 G_I((lag/dt):length(G_I))=tempG_I((lag/dt):length(G_I));