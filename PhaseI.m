clear all
close all
clc

% simulation parameters
t = 0:.1:100;

% constants
gbar_K = 36;
gbar_Na = 120;
gbar_L = 0.3;
E_K = -12;
E_Na = 115;
E_L = 10.6;
V_rest = -70;
C_m = .001;

% calculate gating variables at rest
a_m = .1*((25-V_rest)/(exp((25-V_rest)/10)-1));
B_m = 4*exp(-V_rest/18);
a_n = .01*((10-V_rest)/(exp((10-V_rest)/10)-1));
B_n = .125*exp(-V_rest/80);
a_h = .07*exp(-V_rest/20);
B_h = 1/(exp((30-V_rest)/10)+1);

m = a_m/(a_m+B_m);
n = a_n/(a_n+B_n);
h = a_h/(a_h+B_h);

% calculate g_Na & g_K at rest
g_Na = m^3*gbar_Na*h;
g_K = n^4*gbar_K;

%% steady-state
% plot resting membrane potential
V_m(1:1001) = V_rest;
figure(1)
plot(t,V_m)
xlabel('Time (ms)')
ylabel('Membrane Potential (mV)')

% calculate & plot g_Na/g_K ratio
r(1:1001) = g_Na/g_K;
figure(2)
plot(t,r)
xlabel('Time (ms)')
ylabel('g_{Na}/g_K')

%% step pulse stimulation
% calculate resting currents
I_K = g_K(1)*(V_rest-E_K);
I_Na = g_Na(1)*(V_rest-E_Na);
I_L = gbar_L*(V_rest-E_L);
I_ion = -I_K-I_Na-I_L;

for i = 2:1001
%     calculate membrane potential
    V_m(i) = V_m(i-1)+.1*I_ion/C_m;
    
%     calculate gating variables
    a_m = .1*((25-V_m(i))/(exp((25-V_m(i))/10)-1));
    B_m = 4*exp(-V_m(i)/18);
    a_n = .01*((10-V_m(i))/(exp((10-V_m(i))/10)-1));
    B_n = .125*exp(-V_m(i)/80);
    a_h = .07*exp(-V_m(i)/20);
    B_h = 1/(exp((30-V_m(i))/10)+1);
    
    m = m+.1*(a_m*(1-m)-B_m*m);
    n = n+.1*(a_n*(1-n)-B_n*n);
    h = h+.1*(a_h*(1-h)-B_h*h);
    
%     calculate Na & K channel conductance
    g_Na(i) = m^3*gbar_Na*h;
    g_K(i) = n^4*gbar_K;
    
%     calculate currents
    I_K = g_K(i)*(V_m(i)-E_K);
    I_Na = g_Na(i)*(V_m(i)-E_Na);
    I_L = gbar_L*(V_m(i)-E_L);
    if i < 7
        I_ion = .005-I_K-I_Na-I_L;
    else
        I_ion = -I_K-I_Na-I_L;
    end
end

% plot membrane potential
figure(3)
plot(t,V_m)
xlabel('Time (ms)')
ylabel('Membrane Potential (mV)')

% plot channel conductances
figure(4)
plot(t,g_Na,t,g_K)
legend('g_{Na}','g_K')
xlabel('Time (ms)')
ylabel('Conductance (mS)')

%% constant stimulation
% calculate resting currents
I_K = g_K(1)*(V_rest-E_K);
I_Na = g_Na(1)*(V_rest-E_Na);
I_L = gbar_L*(V_rest-E_L);
I_ion = -I_K-I_Na-I_L;



% plot membrane potential
figure(3)
plot(t,V_m)
xlabel('Time (ms)')
ylabel('Membrane Potential (mV)')

% plot channel conductances
figure(4)
plot(t,g_Na,t,g_K)
legend('g_{Na}','g_K')
xlabel('Time (ms)')
ylabel('Conductance (mS)')
