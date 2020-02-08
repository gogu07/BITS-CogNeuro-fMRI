function [A,B,D,T,G]=base_correction(a,b,d,t,g)

A = a - mean(a,2);
B = b - mean(b,2);
D = d - mean(d,2);
T = t - mean(t,2);
G = g - mean(g,2);
end