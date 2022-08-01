# Demo Hydra program driven by Sonic Pi 4.0.3

This repository shows an example Hydra Sketch which is driven by Sonc Pi 4.0.3
SP provides both an audio feed and a series of OSC calls to the Hydra Script.
These are used to alter various parameters in teh script whilst it is running,
synced to changes in the music which is geenrated by Sonic Pi.

**Hydra-osc support**

In order for this to work, a separate repository https://github.com/ojack/hydra-osc
needs to be installed, together with node.js
use git clone https://github.com/ojack/hydra-osc to install the former in a folder
of your choice. You do not need to install the sample script which is incorporated
in the HydraSketch file.
Install node if you don't have it (check with `node -v`) also check for npm (`npm -v`)
I used the LTS install from https://nodejs.org which gave v16.16.0
open a terminal window in the hydra-osc and type `npm install`

Start the server with `node server.js`
you should see:
```
osc client running on port 41235
osc server running on port 41234
websocket server running on port 8080
```
localhost ip on port 41234 is where Sonic Pi will send OSC calls

**Setting up the HydraSketch on Chrome**
The best browser in which to run the sketch is Chrome.
The easiest way to setup the sketch is to copy the long url text file (use raw file)
and paste it into Chrome. When you load the url it will connect to hydra.ojack.xyz
and the sketch code will be displayed on a black background.
`Shift+Ctrl+H` will toggle the visibility of the code, and it is best turned off
when the sketch is running.

**Connecting Sonic-Pi audio to the Hydra Sketch**
You need to set up a virtual audio device in order to feed audio into Chrome and to the hydra sketch
There is more than one way of doing this. You can either use the commercial LoopBack device
from https://rogueamoeba.com/loopback/ It is expensive but works very well. You can however
install it for free, and use it for up to 20 minutes at a time, before it introduces noise on the audio.

![LoopBack](https://github.com/rbnpi/Sonic-Pi-Hydra/blob/main/assets/LoopbackDevice.png "Loopback Device")

A free way to do it is to install blackhole https://github.com/ExistentialAudio/BlackHole
Download the installer (The 2channel version is fine for this use, but 16 channel is OK too)
You then need to set up a multioutput device using the Audio MIDI Setup app on your Mac.
Follow this guide to do this https://github.com/ExistentialAudio/BlackHole/wiki/Multi-Output-Device

In the Audio MIDI setup Audio window select the multioutput device as your output device, and select
BlackHole as your input device

Make sure that Chrome is added to the list of apps that can use your microphone in System Settings Security and Privacy
Load the Hydra Sketch into Chrome. (Paste and go the raw URL-load.txt file into Chrome)
Select the small microphone symbol towards the right and check that the mic is enabled
and that the default blackhole input device is selected. You can open up the full page if necessary.

![Mic Enable](https://github.com/rbnpi/Sonic-Pi-Hydra/blob/main/assets/ChromeMicSelect.png "Microphone Enable")


**Setting up Sonic Pi**
It is important to start Sonic Pi 4.0.3 AFTER the audio configurations above have been completed.
If it is already running, quit and restart it.  
Initially you need to test the audio connection to Chrome is working.

Load the program below into Sonic Pi and run it.
```
osc_send 'localhost',41234,"/mask",1 #make the sketch visible
use_synth :tb303
live_loop :test do
  play [36,60,84].choose,release: 0.5 #play some notes to give audio input
  sleep 1
end
```
The sketch should become visible on the screen, and should react in time to the notes being played.

You can also change the last line of the sketch code from `a.hide()` to `a.show()`
and click the run arrow top right on the screen, or type Shift+Ctrl+Enter to activate the change.
This will show an audio input bar graph bottom right on the screen.

All being well, you can now load the file `FinalCrosslikeHydraOSC2.rb` into Sonic Pi
You can reduce the visiblity of the Sonic Pi screen on the Preferences/Visuals tab
so that you can place the Sonic Pi window infront of the Chrome window

Run the Sonic Pi program to see the sketch accompanied by the music

**Sundry Items**
The audio volume control on the menubar doesn't work when you use a multioutput device.
Instead you can adjust the audio output to your speaker from Audio MIDI Setup using the two sliders
in the Built-in Output device. YOu can also adjust the audio volume sent to Chrome using the OUTPUT
slider in the blackhole device. I usually use about 50-60% for this, but experiment.

The sketch creates four similar output buffers named o0 to o3. By default 03 is output. YOu can alter
this to o0 to get a differnt display, or look at all four by just using render() with no parameter.
Each time you want to use an alteration re-run the sketch using Shift+Ctrl+Enter.

If you don't like the screen blanking at the end of each run, you can alter the default mask setting
by changing the line `mk=0 //intial value (blanks screen). can set to 1 instead to leave sketch on`
as indicated in the comment, setting mk=1
