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
V(1:101) = V_rest;
figure
plot(t,V)
xlabel('Time (ms)')
ylabel('Voltage (mV)')

% calculate g_Na/g_K and plot g_Na & g_K
r = g_Na/g_K;
gNa(1:101) = g_Na;
gK(1:101) = g_K;
figure
plot(t,gNa)
hold
plot(t,gK)
xlabel('Time (ms)')
ylabel('Conductance (mS/cm^2)')

%% step pulse stimulation


%% constant stimulation

