clc
clear all
close all

%% declare necessary variables here
f = 100:100:2000;
fs = 500;
T = 1./f;
Ts = 1/fs;
periodToObserve = 10;

%% do the main job here
len = length(f);

for i = 1:len
    t = 0:Ts:periodToObserve*T(i);
    x = sin(2*pi*f(i)*t + pi/30);
    
    if i == 11
        figure
    end
    
    j = mod(i,10);
    
    if j == 0
        j = 10;
    end
    
    subplot(5,2,j)
    stem(x)
    lgnd = sprintf('Freq = %d', f(i));
    axis tight
    title(lgnd)
    
end