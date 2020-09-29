### version 0.1.3
- added CHANGELOG
- added output volume slider (read only)
- added volume slider for audioGen (not working yet)
- clean up of layout qml
- 2 output sliders (headphone, speaker)
- get init audio state to GUI
- set output script now turns on and off as well


### version 0.1.2
- included Gutenberg Project audio file (~4mb) in assets folder
- buttons make (bad) click sound
- querying/playing local file using QMediaPlayer
- playing file does not route audio to Headphones when switched
- audio out only goes to whatever ouput set before playing file.
- added a waveform generator to play a continuous tone, does switch outputs
- replaced original handset speaker, now with different freq responses.
- mic unmute now auto-switches output to ensure no feedback
- mic unmute feedback protect can still be overrided with an output change
- button row layout

### version 0.1.1
- separated Mic1 (Handset) and Mic2 (headset) unmute controls
- mute all mics button
- daft looking horizontal separators
- QAudio device list prints to qDebug

### version 0.1.0
- 4 button interface to switch between headphone or speaker output with text info
- volume outputs are hardcoded to 85% on and 2% off
- runs via gProcess calling several bash scripts included in script/ directory
- built for Pinephone CE v1.2a (PostmarketOS) hardware with Ubuntu Touch Version 8 (UBports) running from eMMC
- running speakers and mic unmute will/should produce feedback, so shush it now.
- compiled with $ clickable --arch arm64 --ssh [ipaddr]
- check README.md for latest info

### version 0.0.3
- Simplifed interface with 2 buttons controlling to enable headphone or speaker volume
- updates text label with current volume of which ever audio out is enabled
- C++ end is messy and runs 4 scripts to achieve current function state.
- clickable arm64 install via ssh

### version 0.0.2
- unmutes headphones
- sets volumes for Line Out and Headphones to hardcoded levels
- read volumes for Line Out and Headphones and print to QDebug, ie. as "75\n"
- start of qml read vol

### version 0.0.1
- arm64.click for Pinephone
- template.click and arm64 proper
- no function, portaudio include build (removed)
- transfer builds due to no ssh, num 24 audio, num 31 temp-0.0.2 ARM64
