clear all
close all
clc

% simulation parameters
dt = .01;
t = 0:dt:100;

% stimulation values
I = 50;
t_s = 5*1/dt; %change # before 1/dt to anything <= max(t)

% constants
gbar_K = 36;
gbar_Na = 120;
gbar_L = .3;
E_K = -12;
E_Na = 115;
E_L = 10.6;
V_rest = -70;
C_m = 1;

% calculate displacement of potentials from rest
V_m = V_rest;
V = abs(V_m)-abs(V_rest);
V_K = E_K-abs(V_rest);
V_Na = E_Na-abs(V_rest);
V_L = E_L-abs(V_rest);

% calculate gating variables at rest
a_m = .1*((25-V)/(exp((25-V)/10)-1));
B_m = 4*exp(-V/18);
a_n = .01*((10-V)/(exp((10-V)/10)-1));
B_n = .125*exp(-V/80);
a_h = .07*exp(-V/20);
B_h = 1/(exp((30-V)/10)+1);

m = a_m/(a_m+B_m);
n = a_n/(a_n+B_n);
h = a_h/(a_h+B_h);

% calculate g_Na & g_K at rest
g_Na = m^3*gbar_Na*h;
g_K = n^4*gbar_K;

% iterate for values over simulation period
for i = 1:length(t)-1
%     calculate gating variables
    a_m = .1*((25-V(i))/(exp((25-V(i))/10)-1));
    B_m = 4*exp(-V(i)/18);
    a_n = .01*((10-V(i))/(exp((10-V(i))/10)-1));
    B_n = .125*exp(-V(i)/80);
    a_h = .07*exp(-V(i)/20);
    B_h = 1/(exp((30-V(i))/10)+1);
    
    m = m+dt*(a_m*(1-m)-B_m*m);
    n = n+dt*(a_n*(1-n)-B_n*n);
    h = h+dt*(a_h*(1-h)-B_h*h);
    
%     calculate conductances
    g_Na(i+1) = m^3*gbar_Na*h;
    g_K(i+1) = n^4*gbar_K;
    
%     calculate currents
    I_Na = g_Na(i+1)*(V_m(i)-V_Na);
    I_K = g_K(i+1)*(V_m(i)-V_K);
    I_L = gbar_L*(V_m(i)-V_L);
    if i <= t_s
        I_ion = (I-I_K-I_Na-I_L);
    else
        I_ion = (-I_K-I_Na-I_L);
    end
    
%     calculate membrane potential
    V(i+1) = V(i)+dt*I_ion/C_m;
    V_m(i+1) = V_rest+V(i+1);
end

% plot resting membrane potential
figure(1)
plot(t,V_m)
xlabel('Time (ms)')
ylabel('Membrane Potential (mV)')

% plot g_Na & g_K
figure(2)
plot(t,g_Na,t,g_K)
legend('g_{Na}','g_K')
xlabel('Time (ms)')
ylabel('Conductance (mS/cm^2)')
