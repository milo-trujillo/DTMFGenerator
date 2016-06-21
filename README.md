# DTFM Tone Generator

Makes [DTFM tones](http://www.dialabc.com/sound/dtmf.html) and saves them to a wave file. Maybe useful for phone phreaking in the 90s, now it's pretty much a novelty. You can test that it works by [submitting your wav file](http://dialabc.com/sound/detect/index.html) for testing.

## Usage:

    tone.rb <outputname.wav> tone1 ...

For example, to generate the noise of dialing "1234":

    tone.rb dialing.wav 1 2 3 4
