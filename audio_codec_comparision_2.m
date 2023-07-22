%Load  
[original,Fs1] = audioread('original.wav');
[mp3,Fs2] = audioread('audio.mp3');
[aac,Fs3] = audioread('audio.aac');

% Same number of channels
if size(original,2) == 2
    original = mean(original,2);
end
if size(mp3,2) == 2
    mp3 = mean(mp3,2);
end
if size(aac,2) == 2
    aac = mean(aac,2);
end

% Same sampling rate
if Fs2 ~= Fs1
    [P,Q] = rat(Fs1/Fs2);
    mp3 = resample(mp3, P, Q);
end
if Fs3 ~= Fs1
    [P,Q] = rat(Fs1/Fs3);
    aac = resample(aac, P, Q);
end

% Same length
minLength = min([length(original), length(mp3), length(aac)]);
original = original(1:minLength);
mp3 = mp3(1:minLength);
aac = aac(1:minLength);

% FFT
NFFT = 2^nextpow2(minLength); 
f = Fs1/2*linspace(0,1,NFFT/2+1);
Y_original = fft(original,NFFT)/minLength;
Y_mp3 = fft(mp3,NFFT)/minLength;
Y_aac = fft(aac,NFFT)/minLength;

% Plot 
figure;
subplot(3,1,1);
plot(f,2*abs(Y_original(1:NFFT/2+1))) 
title('Frequency Response of Original')
subplot(3,1,2);
plot(f,2*abs(Y_mp3(1:NFFT/2+1))) 
title('Frequency Response of MP3')
subplot(3,1,3);
plot(f,2*abs(Y_aac(1:NFFT/2+1))) 
title('Frequency Response of AAC')

%Power Spectral Density 

figure;
subplot(3,1,1);
pwelch(original,[],[],[],Fs1)
title('Power Spectral Density of Original')
subplot(3,1,2);
pwelch(mp3,[],[],[],Fs1)
title('Power Spectral Density of MP3')
subplot(3,1,3);
pwelch(aac,[],[],[],Fs1)
title('Power Spectral Density of AAC')


%Zero Crossing Rate 

zcr_original = sum(abs(diff(original>0)))/length(original);
zcr_mp3 = sum(abs(diff(mp3>0)))/length(mp3);
zcr_aac = sum(abs(diff(aac>0)))/length(aac);
disp(['Zero-crossing Rate of Original: ', num2str(zcr_original)])
disp(['Zero-crossing Rate of MP3: ', num2str(zcr_mp3)])
disp(['Zero-crossing Rate of AAC: ', num2str(zcr_aac)])
