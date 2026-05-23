% MATLAB code to generate DTMF signal values

clc
clear all
close all
fs = 16384;
N = 1024;
T = (N-1)/fs;
t = 0:1/fs:T;
n=1:N;
low=[697 770 852 941];
high=[1209 1336 1477 1633];
f=[697 770 852 941 1209 1336 1477 1633] 
numbers=['1' '2' '3' 'A'; '4' '5' '6' 'B'; '7' '8' '9' 'C'; '*' '0' '#' 'D']
f1=941;
f2=1633;
y1=5*sin(2*pi*f1*t);
y2=5*sin(2*pi*f2*t);
signal=y1+y2;
fileID = fopen('signaldata_D.txt','w');
fprintf(fileID, '%12s\r\n','wave');
for i=signal
     signaldata=float2bin(i);
     fprintf(fileID,'%32s\r\n',signaldata(1:32));
end
fclose(fileID);
Plot the waveform of the generated signal
plot(t, signal);
title('DTMF waveform for key D');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
