clc
clear all
close all

% this code generates sargam and shows the effects of sampling rate
% alteration on the main signal

%% declare variables
f = [240, 270, 300, 320, 360, 400, 450, 480]; %in hertz
%sa   re   ga   ma   pa   dha  ni   sa'
fs = 2000; %in hertz
TimeToListen = [2 1.2 1 .6 .01 .6 .8 1.1]; %in second
intensity1 = [0.3,0.2,0.4,0.1,15,.5,.3,.6];
waveform=[];

%% do the main job here

for i=1:1:8
    
    tones=f(i);
    intensity=intensity1(i);
    
    t = 1/fs: 1/fs : TimeToListen(i) ;
    out=intensity*sin(2*pi*tones*t);
    
    waveform=[waveform, out];
    
end

% len = length(waveform);
% waveform(len+1 : 2*len) = filplr(waveform(1:len));

%% play the music

playr = audioplayer(waveform, fs);

play(playr,fs);

%%
%playr = audioplayer(fliplr(waveform), fs);
%play(playr,fs);
while 1
    disp('press ctrl+c to exit')
    usr = input('Uniform/ non-uniform?:(1 for uniform and any oter key for non-uniform)\n');
    bit = input('bit number? : ');
    
    pause(1);
    %% normalization
    x=waveform;
    maxVal=abs(max(x));
    x_norm=x./maxVal;
    u=255;
    %% compression
    Y1=(log(1+u.*abs(x_norm)))./(log(1+u));
    Y2=Y1.*sign(x_norm);
    % disp(Y2);
    
    %% uniform quantizer with compression
    %     bit=5;
    L=2^bit-1;
    del=(max(Y2)-min(Y2))/L;
    xq=(round((Y2-min(Y2))/del))*del+min(Y2);
    xq1=(((1+u).^(abs(xq))-1)./u).*sign(xq)*maxVal;
    %% play the audio with compression
    
    playr1 = audioplayer(xq1, fs);
    
    play(playr1,fs);
    %%
    %playr1 = audioplayer(fliplr(xq1), fs);
    %play(playr1,fs);
    %% uniform quantizer without compression
    z=waveform;
    %     bit=5;
    L=2^bit-1;
    del=(max(z)-min(z))/L;
    zq=(round((z-min(z))/del))*del+min(z);
    
    %% plots
    
    time = sum(TimeToListen);
    t1 = 1/fs:1/fs:time;
    
    
    
    %% play the audio without compression
    
    if usr == 1
        data = zq;
    else
        data = xq1;
    end
    
    playr2 = audioplayer(data, fs);
    
    play(playr2,fs);
end
%%
%playr2 = audioplayer(fliplr(zq), fs);
%play(playr2,fs);