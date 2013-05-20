function[cp] = cpCO2(t)
    % caculate the cp of CO2, using spline interp
    ts1 = 250:50:600;
    ts = [220, ts1];
    cps = [0.783, 0.804, 0.871, 0.900, 0.942, 0.980, 1.013, 1.047, 1.076];
    
    cp = interp1(ts, cps, t, '*spline');
end