---
aliases:
  - circuit board
  - circuit python
draft: false
tags:
  - computerscience
title: Circuit Playground Express
date: 2024-08-07
updated: 2024-08-20T21:55
---

-------------------------------------------------------------------------------

I was listening to a podcast from [Real Python](https://realpython.com/) that mentioned getting your hands on a Circuit Playground Express. It was in passing and I probably wouldn't have ordered one, had I not seen one for sale at Micro Center for only $30. 

From my understanding, it's a very basic introduction to using circuit boards, and I got it mostly because of something called [Circuit Python](https://circuitpython.org/), which is a version of Python meant to introduce students and beginners into controlling single board computers (SBC's).

[Link](https://learn.adafruit.com/adafruit-circuit-playground-express) to the documentation.

So, of course, the circuit playground I bought has one of it's speakers blown. Not the biggest deal. As I went through the documentation I kept thinking to myself that this is pretty much an extremely basic Flipper. That might end up being my project for this thing; attach some Bluetooth capabilities to it to get it up to Flipper level.

Mu is the editor preferred for the using Circuit Python. It's a really lite editor that picks up the Circuit Playground with ease.

You can give it commands via a **code.py** file stored directly on the SBC. The following will set one of the LED's to blink:

```python
# Write your code here :-)
import board
import digitalio
import time

led = digitalio.DigitalInOut(board.LED)
led.direction = digitalio.Direction.OUTPUT

while True:
    led.value = True
    time.sleep(1)
    led.value = False
    time.sleep(2)
```


The following will play audio files stored on the SBC:

```python
# SPDX-FileCopyrightText: 2017 Limor Fried for Adafruit Industries
#
# SPDX-License-Identifier: MIT

import board
import digitalio

try:
    from audiocore import WaveFile
except ImportError:
    from audioio import WaveFile

try:
    from audioio import AudioOut
except ImportError:
    try:
        from audiopwmio import PWMAudioOut as AudioOut
    except ImportError:
        pass  # not always supported by every board!

# Enable the speaker
spkrenable = digitalio.DigitalInOut(board.SPEAKER_ENABLE)
spkrenable.direction = digitalio.Direction.OUTPUT
spkrenable.value = True

# Make the 2 input buttons
buttonA = digitalio.DigitalInOut(board.BUTTON_A)
buttonA.direction = digitalio.Direction.INPUT
buttonA.pull = digitalio.Pull.DOWN

buttonB = digitalio.DigitalInOut(board.BUTTON_B)
buttonB.direction = digitalio.Direction.INPUT
buttonB.pull = digitalio.Pull.DOWN

# The two files assigned to buttons A & B
audiofiles = ["rimshot.wav", "laugh.wav"]


def play_file(filename):
    print("Playing file: " + filename)
    wave_file = open(filename, "rb")
    with WaveFile(wave_file) as wave:
        with AudioOut(board.SPEAKER) as audio:
            audio.play(wave)
            while audio.playing:
                pass
    print("Finished")


while True:
    if buttonA.value:
        play_file(audiofiles[0])
    if buttonB.value:
        play_file(audiofiles[1])

```
