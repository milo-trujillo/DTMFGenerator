#!/usr/bin/env ruby
require 'wavefile'

SAMPLE_RATE = 22050 # Hertz
TONE_LENGTH = SAMPLE_RATE / 2 # Half a second
TWO_PI = 2 * Math::PI
Volume = 0.3 # 0.0 is silent, 1.0 is max volume (amplitude)

# Adds two sine waves together to make a DTFM tone
def generate_tone(freq1, freq2, amplitude)
	wav1 = generate_sine_wave(TONE_LENGTH, freq1, amplitude)
	wav2 = generate_sine_wave(TONE_LENGTH, freq2, amplitude)
	wav = []
	for i in (0 .. (wav1.size - 1))
		wav.push(wav1[i] + wav2[i])
	end
	return wav
end

# Makes an audio sine wave of specific length, frequency, and amplitude
def generate_sine_wave(num_samples, frequency, max_amplitude)
	position_in_period = 0.0
	position_in_period_delta = frequency / SAMPLE_RATE
	samples = []

	num_samples.times do
		# Get the correct value from the sin curve, then move up
		samples.push(Math::sin(position_in_period * TWO_PI) * max_amplitude)
		position_in_period += position_in_period_delta
		
		# Constrain the period between 0.0 and 1.0.
		# That is, keep looping and re-looping over the same period.
		if(position_in_period >= 1.0)
			position_in_period -= 1.0
		end
	end
	return samples
end

# Here's all the sounds we'll need, including silence
digits = []
digits.push(generate_tone(941.0, 1336.0, Volume)) # 0
digits.push(generate_tone(697.0, 1209.0, Volume)) # 1
digits.push(generate_tone(697.0, 1336.0, Volume)) # 2
digits.push(generate_tone(697.0, 1477.0, Volume)) # 3
digits.push(generate_tone(770.0, 1209.0, Volume)) # 4
digits.push(generate_tone(770.0, 1336.0, Volume)) # 5
digits.push(generate_tone(770.0, 1477.0, Volume)) # 6
digits.push(generate_tone(852.0, 1209.0, Volume)) # 7
digits.push(generate_tone(852.0, 1336.0, Volume)) # 8
digits.push(generate_tone(852.0, 1477.0, Volume)) # 9
format = WaveFile::Format.new(:mono, :float, SAMPLE_RATE)
silence = WaveFile::Buffer.new(([0] * TONE_LENGTH), format)

if __FILE__ == $0
	if( ARGV.size < 2 )
		puts "USAGE: #{$0} <outputname.wav> tone1 ..."
		exit
	end

	file = ARGV.shift
	sequence = ARGV.map { |d| d.to_i }

	pcm_format = WaveFile::Format.new(:mono, :pcm_16, SAMPLE_RATE)
	WaveFile::Writer.new(file, pcm_format) do |writer|
		for digit in sequence
			if( digit < 0 or digit > 9 )
				next
			end
			buffer = WaveFile::Buffer.new(digits[digit], format)
			writer.write(buffer)
			writer.write(silence)
		end
	end
end
