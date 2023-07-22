%Load Files 
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

%SNR 
SNR_mp3 = snr(original, original-mp3);
SNR_aac = snr(original, original-aac);

%THD
THD_mp3 = thd(mp3);
THD_aac = thd(aac);

% Spectrogram difference
[originalSpectrogram,F,T] = spectrogram(original,256,[],[],Fs1,'yaxis');
[mp3Spectrogram,~,~] = spectrogram(mp3,256,[],[],Fs1,'yaxis');
[aacSpectrogram,~,~] = spectrogram(aac,256,[],[],Fs1,'yaxis');
differenceSpectrogram_mp3 = 10*log10(abs(originalSpectrogram)) - 10*log10(abs(mp3Spectrogram));
differenceSpectrogram_aac = 10*log10(abs(originalSpectrogram)) - 10*log10(abs(aacSpectrogram));

figure;
subplot(3,1,1)
imagesc(T,F,10*log10(abs(originalSpectrogram)));
axis xy; colormap(jet); colorbar;
title('Spectrogram of Original');
ylabel('Frequency (Hz)'); xlabel('Time (s)');

subplot(3,1,2)
imagesc(T,F,10*log10(abs(mp3Spectrogram)));
axis xy; colormap(jet); colorbar;
title('Spectrogram of MP3');
ylabel('Frequency (Hz)'); xlabel('Time (s)');

subplot(3,1,3)
imagesc(T,F,differenceSpectrogram_mp3);
axis xy; colormap(jet); colorbar;
title('Difference MP3');
ylabel('Frequency (Hz)'); xlabel('Time (s)');

figure;
subplot(3,1,1)
imagesc(T,F,10*log10(abs(originalSpectrogram)));
axis xy; colormap(jet); colorbar;
title('Spectrogram of Original');
ylabel('Frequency (Hz)'); xlabel('Time (s)');

subplot(3,1,2)
imagesc(T,F,10*log10(abs(aacSpectrogram)));
axis xy; colormap(jet); colorbar;
title('Spectrogram of AAC');
ylabel('Frequency (Hz)'); xlabel('Time (s)');

subplot(3,1,3)
imagesc(T,F,differenceSpectrogram_aac);
axis xy; colormap(jet); colorbar;
title('Difference AAC');
ylabel('Frequency (Hz)'); xlabel('Time (s)');

% Time Domain plot
time = (1:minLength)/Fs1;
figure;
subplot(3,1,1)
plot(time,original)
title('Time Domain Plot - Original')
subplot(3,1,2)
plot(time,mp3)
title('Time Domain Plot - MP3')
subplot(3,1,3)
plot(time,aac)
title('Time Domain Plot - AAC')

% Spectral Line Plot
figure;
subplot(3,1,1)
plot(abs(fft(original)))
title('Spectral Line Plot - Original')
subplot(3,1,2)
plot(abs(fft(mp3)))
title('Spectral Line Plot - MP3')
subplot(3,1,3)
plot(abs(fft(aac)))
title('Spectral Line Plot - AAC')
