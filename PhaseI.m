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
% determine currents
I_Na = m^3*g_Na*h*(V_m-E_Na);
I_K = n^4*g_K*(V_m-E_K);
I_L = g_L*(V_m-E_L);
I_ion(1:.5:10) = 0-I_K-I_Na-I_L;
I_ion(11:.5:11.5) = .005-I_K-I_Na-I_L;
I_ion(12:.5:101) = 0-I_K-I_Na-I_L;


%% constant stimulation
% determine currents
I_Na = m^3*g_Na*h*(V_m-E_Na);
I_K = n^4*g_K*(V_m-E_K);
I_L = g_L*(V_m-E_L);
I_ion(1:100) = .001-I_K-I_Na-I_L;
