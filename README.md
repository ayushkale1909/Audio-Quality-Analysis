# Audio-Quality-Analysis
Comparative Audio Quality Analysis of MP3 and AAC Compression Formats

## Description

This project analyzes an original audio file to its compressed variants in MP3 and AAC codecs using audio analysis. 

The main objective is to understand how these popular lossy compression formats affect audio quality and signal properties.

A preprocessing step ensures that the audio files are compared fairly by making the three audio files (original (.wav) , MP3, and AAC) have the same number of channels, sample rate, and length. 

## Results 

### SNR 

SNR between the original audio and the compressed audio files is calculated. 

A higher SNR indicates a higher quality audio file, meaning the noise introduced due to compression is low.

### THD (Total Harmonic Distortion) 

This measurement tells about the harmonic distortion introduced in the audio due to compression.

### Spectrogram Comparison

Spectrograms and the difference between the spectrograms of the original and compressed audio files provide a visual way to examine the change in  frequency content of the audio files.   

### Time-Domain Plot

Original and compressed audio signals are plotted in the time domain to see how the signal's waveform is altered. 

### Spectral Line Plot 

Magnitude of the FFT (Fast Fourier Transform) of the original and compressed audio signals is plotted. 

This gives a visualization of the audio signal's frequency content.

## Summary 

Overall, this project offers numerical metrics (SNR, THD) as well as visual tools (spectrograms, time-domain plots, spectral line graphs) for analyzing and comparing the quality of audio files in their original and compressed versions.

