%*****************************************************************************
% Copyright (c) 2013-2015 Signal Processing and Acoustic Technology Group    *
%                         SPAT, ETSE, Universitat de València                *
%                         46100, Burjassot, Valencia, Spain                  *
%                                                                            *
% This file is part of the SART3D: 3D Spatial Audio Rendering Toolbox.       *
%                                                                            *
% SART3D is free software:  you can redistribute it and/or modify it  under  *
% the terms of the  GNU  General  Public  License  as published by the  Free *
% Software Foundation, either version 3 of the License,  or (at your option) *
% any later version.                                                         *
%                                                                            *
% SART3D is distributed in the hope that it will be useful, but WITHOUT ANY  *
% WARRANTY;  without even the implied warranty of MERCHANTABILITY or FITNESS *
% FOR A PARTICULAR PURPOSE.                                                  *
% See the GNU General Public License for more details.                       *
%                                                                            *
% You should  have received a copy  of the GNU General Public License  along *
% with this program.  If not, see <http://www.gnu.org/licenses/>.            *
%                                                                            *
% SART3D is a toolbox for real-time spatial audio prototyping that lets you  *
% move in real time virtual audio sources from a set of WAV files using      *
% multiple spatial audio rendering methods.                                  *
%                                                                            *
% https://github.com/spatUV/SART3Dmaster                  maximo.cobos@uv.es *
%*****************************************************************************

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