# DTMF Tone Generator

Makes [DTMF tones](http://www.dialabc.com/sound/dtmf.html) and saves them to a wave file. Maybe useful for phone phreaking in the 60s or 70s, now it's pretty much a novelty. You can test that it works by [submitting your wave file](http://dialabc.com/sound/detect/index.html) for testing.

## Usage

	./tone.rb [options] <digits> <outputfile>
		-p, --pause PAUSE             Sets delay between each tone (in seconds)
		-v, --volume VOLUME           Sets volume between 0 (silent) and 1 (max)
		-h, --help                    Displays this usage message
		<digits>                      Specifies digit tones to emulate
		<outputfile>                  Specifies name of output wave file

For example, to generate the noise of dialing "1234":

    tone.rb 1234 dialing.wav

To do the same with a tenth of a second delay instead of our default half a second, and with twice the default volume of 0.3:

    tone.rb -p 0.1 -v 0.6 1234 dialing.wav

## Dependencies

We make heavy use of the [wavefile ruby gem](http://wavefilegem.com/). Everything is in pure ruby, nothing else is needed.
