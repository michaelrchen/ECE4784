clear all
close all
clc

% stimulation values in uA/cm^2 and .1 ms
I = 5; 
t_s = 0;

% simulation parameters
t = 0:.1:100;

% constants
gbar_K = 36;
gbar_Na = 120;
g_L = .3;
E_K = -12;
E_Na = 115;
E_L = 10.6;
V_m = -70;
C_m = 1;

% calculate gating variables at rest
a_m = .1*((25-(V_m-V_m))/(exp((25-(V_m-V_m))/10)-1));
B_m = 4*exp(-(V_m-V_m)/18);
a_n = .01*((10-(V_m-V_m))/(exp((10-(V_m-V_m))/10)-1));
B_n = .125*exp(-(V_m-V_m)/80);
a_h = .07*exp(-(V_m-V_m)/20);
B_h = 1/(exp((30-(V_m-V_m))/10)+1);

m = a_m/(a_m+B_m);
n = a_n/(a_n+B_n);
h = a_h/(a_h+B_h);

% calculate g_Na & g_K at rest
g_Na = m^3*gbar_Na*h;
g_K = n^4*gbar_K;

% iterate for values over simulation period
for i = 1:1000
%     calculate gating variables
    a_m = .1*((25-(V_m(i)-V_m(1)))/(exp((25-(V_m(i)-V_m(1)))/10)-1));
    B_m = 4*exp(-(V_m(i)-V_m(1))/18);
    a_n = .01*((10-(V_m(i)-V_m(1)))/(exp((10-(V_m(i)-V_m(1)))/10)-1));
    B_n = .125*exp(-(V_m(i)-V_m(1))/80);
    a_h = .07*exp(-(V_m(i)-V_m(1))/20);
    B_h = 1/(exp((30-(V_m(i)-V_m(1)))/10)+1);
    
    m = m+.1*(a_m*(1-m)-B_m*m);
    n = n+.1*(a_n*(1-n)-B_n*n);
    h = h+.1*(a_h*(1-h)-B_h*h);
    
%     calculate conductances
    g_Na(i+1) = m^3*gbar_Na*h;
    g_K(i+1) = n^4*gbar_K;
    
%     calculate currents
    I_Na = g_Na(i+1)*((V_m(i)-V_m(1))-(E_Na-V_m(1)));
    I_K = g_K(i+1)*((V_m(i)-V_m(1))-(E_K-V_m(1)));
    I_L = g_L*((V_m(i)-V_m(1))-(E_L-V_m(1)));
    if i <= t_s
        I_ion = (I-I_K-I_Na-I_L)/1000;
    else
        I_ion = (-I_K-I_Na-I_L)/1000;
    end
    
%     calculate membrane potential
    V_m(i+1) = V_m(1)+.1*I_ion/C_m;
%     V_m(i+1) = V_m(i)+.1*I_ion/C_m;
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
