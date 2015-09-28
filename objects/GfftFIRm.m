classdef GfftFIRm < handle
    properties
        WinLen   = 1024;                % Window Length (default)
        Filter   = 0;                  % FIR filter coefficients
        LastFilter = 0;                % Previous filter coefficients
    end
    properties (SetAccess = private)
        FiltLen;                        % Filter length
        Nfft;                           % FFT size
    end
    properties (Hidden = true);
        FiltFFT;                        % DFT of Filter
        audioSave;                      % Saved audio samples (overlap add)
        SaveLen;                        % Length of saved samples
        LastFiltFFT;                    % DFT of previous filter
        LastaudioSave;                  % Saved samples from previous filter
    end
    methods
        function FT = GfftFIRm(WinLen,Filter)    % Constructor      
            FT.WinLen   = WinLen;
            FT.Filter   = Filter;
            FT.LastFilter = Filter;              
            FT.FiltLen  = length(Filter);
            if FT.FiltLen ~= 1
                FT.SaveLen  = FT.FiltLen-1;
                FT.Nfft     = 2^nextpow2(WinLen + FT.FiltLen -1);
                FT.FiltFFT  = fft(Filter,FT.Nfft);
                FT.audioSave = zeros(WinLen,1);
                FT.LastFiltFFT = FT.FiltFFT;
                %FT.LastaudioSave = zeros(WinLen,1);
            end
          
        end
        function [] = UpdateFilter(FT,Filter)   % Filter update
            FT.Filter  = Filter;
            FT.FiltLen  = length(Filter);
            if FT.FiltLen ~= 1
                FT.FiltFFT = fft(Filter,FT.Nfft);
            end
        end
        function audioout = steplast(FT,InputFrame) % Filter audio with previous filter
            if FT.FiltLen ~= 1
                audioFFT = fft(InputFrame,FT.Nfft);
                audioFil = ifft(audioFFT.*FT.LastFiltFFT);
                audioout = audioFil(1:FT.WinLen)+ FT.audioSave;
                %FT.LastaudioSave(1:FT.SaveLen) = audioFil(FT.WinLen+1:FT.WinLen+FT.SaveLen);
            else
                audioout = FT.LastFilter * InputFrame;
            end
        end
        function audioout = step(FT,InputFrame) % Filter audio with current filter
            if FT.FiltLen ~= 1
                audioFFT = fft(InputFrame,FT.Nfft);
                audioFil = ifft(audioFFT.*FT.FiltFFT);
                audioout = audioFil(1:FT.WinLen)+ FT.audioSave;
                FT.audioSave(1:FT.SaveLen) = audioFil(FT.WinLen+1:FT.WinLen+FT.SaveLen);
            else
                audioout = FT.Filter * InputFrame;
            end
            FT.LastFilter = FT.Filter;         % Update previous filter
            if FT.FiltLen ~= 1
                FT.LastFiltFFT = FT.FiltFFT;
            end
        end
        function [lf,cf] = getFilters(FT)
            lf = FT.LastFilter;
            cf = FT.Filter;
        end
    end
end