function [ cp ] = cpBFG( )
% show the cp of BFG, 20 degree C
%   Detailed explanation goes here

% cp of each kind gas, kJ/(kg*K)
cpco2 = 0.858;
cpo2 = 0.909;
cpco = 1.040;
cpch4 = 2.250;
cph2 = 14.450;
cpn2 = 1.040;

rco2 = 19.59;
ro2 = 0.35;
rco = 26.7;
rch4 = 0;
rh2 = 2.51;
rn2 = 50.83;

cp = (cpco2 * rco2*44 +  cpo2 * ro2*32 + cpco * rco*28 + cph2 * rh2*2 + cpn2 * rn2*28) / (rco2*44 + ro2*32 + rco*28 + rh2*2 + rn2*28)
end

