**Demo Hydra program driven by Sonic Pi 4.0.3**

This repository shows an example Hydra Sketch which is drive
n by Sonc Pi 4.0.3
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

**Setting up Sonic Pi**
Run Sonic Pi 4.0.3 and open the file `FinalCrosslikeHydraOSC2.rb`
You can reduce the visiblity of the Sonic Pi screen on the Preferences/Visuals tab
so that you can place the Sonic Pi window infront of the Chrome window

Run the Sonic Pi program to see the sketch accompanied by the music

EDIT missing details of using a loopback to feed sound from Sonic Pi to Chrome.
WILL BE ADDED TOMORROW
