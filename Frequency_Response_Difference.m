% FFT
NFFT = 2^nextpow2(minLength); 
f = Fs1/2*linspace(0,1,NFFT/2+1);
Y_original = fft(original,NFFT)/minLength;
Y_mp3 = fft(mp3,NFFT)/minLength;
Y_aac = fft(aac,NFFT)/minLength;


% Frequency Response
freq_resp_original = 2*abs(Y_original(1:NFFT/2+1));
freq_resp_mp3 = 2*abs(Y_mp3(1:NFFT/2+1));
freq_resp_aac = 2*abs(Y_aac(1:NFFT/2+1));

% Difference in frequency response
diff_freq_resp_mp3 = abs(freq_resp_original - freq_resp_mp3);
diff_freq_resp_aac = abs(freq_resp_original - freq_resp_aac);

figure;
subplot(2,1,1)
plot(f, diff_freq_resp_mp3)
title('Difference in Frequency Response - Original vs MP3')
xlabel('Frequency (Hz)')
ylabel('Magnitude')

subplot(2,1,2)
plot(f, diff_freq_resp_aac)
title('Difference in Frequency Response - Original vs AAC')
xlabel('Frequency (Hz)')
ylabel('Magnitude')
