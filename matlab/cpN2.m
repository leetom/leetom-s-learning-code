function [cp] = cpN2(t)
    % cpN2(t), t should be in  Kelvin scale
    ts = 200:100:1200;
    cps = [1.0429, 1.0408, 1.0459, 1.0555, 1.0756, 1.0969, 1.1225, 1.1464, 1.1677, 1.1857, 1.2037];
    
    cp = interp1(ts, cps, t, '*spline');
    
end