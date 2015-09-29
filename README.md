![Image](doc/img/spat.png)

SART3D: 3D Spatial Audio Reproduction Toolbox
=============================================

### Table of Contents

**[Requirements](#requirements)**  
**[What can I do with SART3D?](#description)**   
**[Which spatial audio rendering methods are supported?](#methods)**    
**[How do I give it a quick try](#usage)**  
**[How can I change the set-up](#changesetup)**   
  [Can I see an example](#setupexample)   
**[How do I create a new rendering method?](#newmethod)**   
**[Credits and License](#credits-and-license)**

Requirements
------------

* **Matlab R2013b** (or later version)
* **Signal Processing Toolbox** (Mathworks)
* **DSP System Toolbox** (Mathworks)
* **Sound Field Synthesis Toolbox** (optional, for reproducing sound field synthesis methods. Get it [here](https://github.com/sfstoolbox/sfs).)
* **Audio hardware with ASIO drivers**. If your soundcard does not have specific ASIO drivers, you can install generic [ASIO4ALL v2](http://www.asio4all.com/) drivers.


What can I do with SART3D?
--------------------------

SART3D lets you move in real time virtual audio sources from a set of WAV files using multiple spatial audio rendering methods. You can specify locations of virtual sources and loudspeakers and change among the different available rendering methods.

The programmatic structure of the GUI lets the user experience with any loudspeaker setup specified in the configuration structure.
The modular design of the Toolbox lets the user create new rendering methods and experiment with different parameters. As a result, SART3D is a very useful tool for spatial audio research and education.

Which spatial audio rendering methods are supported?
----------------------------------------------------

Currently, the toolbox incorporates:

* VBAP (Vector Base Amplitude Panning)
* Stereo Panning Sine Law
* Stereo Panning Tangent Law
* Ambisonics Amplitude Panning
* Binaural Rendering
* Wave Field Synthesis (using the SFS Toolbox)
* Near-Field Compensated Higher Order Ambisonics (using the SFS Toolbox)


How do I give it a quick try?
-----------------------------

To start playing with SART3D, just be sure to have an available ASIO driver in your system.

*Step 1:* First, go to Matlab’s Preferences and set DSP System Toolbox Audio API to ASIO.

![Image](doc/img/ASIO.png)

*Step 2:* Then, change the current Matlab’s working folder to your SART3D folder and type: 

```Matlab
SART3Dini;
SART3D
```
This will add the folder structure into Matlab’s path and will run the main GUI. The toolbox is configured to load automatically a default two-loudspeaker set-up.

![Image](doc/img/default.png)

*Step 3:* Check that the bottom pop-up menu contains the ASIO driver that you want to use. Here you can also select the ASIO buffer size and the rendering method.

![Image](doc/img/driver.png)

*Step 4:* To start listening to a given sound source, select the ones that you want to hear using the checkboxes and push the play button in the top left corner. Drag and drop the sources to different locations or specify positions using the input edit text boxes. Stop the playback by pressing again the play button.

![Image](doc/img/sources.png)

