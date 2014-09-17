clear all
close all
clc

% simulation parameters
t = 0:100; %ms

% constants
g_K = 36;
g_Na = 120;
g_L = 0.3;
E_K = -12;
E_Na = 115;
E_L = 10.6;
V_rest = -70;

%% steady-state neuron
% plot resting membrane potential
V_m(1:101) = V_rest;
figure(1)
plot(t,V_m)
xlabel('Time (ms)')
ylabel('Membrane Potential (mV)')

% calculate resting g_Na/g_K and plot g_Na & g_K
r(1:101) = g_Na/g_K;
figure(2)
plot(t,r)
xlabel('Time (ms)')
ylabel('g_{Na}/g_K')

%% step pulse stimulation
% initialization
V_m = V_rest;
t = .5;

% gating variables
a_m = .1*((25-V_m)/exp((25-V_m)/10)-1);
B_m = 4*exp(-V_m/18);
a_n = .01*((10-V_m)/(exp((10-V_m)/10)-1));
B_n = .125*exp(-V_m/80);
a_h = .07*exp(-V_m/20);
B_h = 1/(exp((30-V_m)/10)+1);

% state variables
m = (-a_m/(a_m+B_m))*exp(t*(-a_m-B_m))+(a_m/(a_m+B_m));
n = (-a_n/(a_n+B_n))*exp(t*(-a_n-B_n))+(a_n/(a_n+B_n));
h = (-a_h/(a_h+B_h))*exp(t*(-a_h-B_h))+(a_h/(a_h+B_h));

% determine currents
I_Na = m^3*g_Na*h*(V_m-E_Na);
I_K = n^4*g_K*(V_m-E_K);
I_L = g_L*(V_m-E_L);
I_ion = I-I_K-I_Na-I_L;

%% constant stimulation
% determine currents
I_Na = m^3*g_Na*h*(V_m-E_Na);
I_K = n^4*g_K*(V_m-E_K);
I_L = g_L*(V_m-E_L);
I_ion(1:100) = .001-I_K-I_Na-I_L;
