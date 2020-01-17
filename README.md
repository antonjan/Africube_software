# Africube_software
This repository will have the Transponder and Telemetry software applications.

# Exsample for rpitx V2 not (usable on PI 4)
## Send Audio from svxlink
in svxlink.conf, [Tx1]<br>
AUDIO_DEV=udp:127.0.0.1:1233<br>
arecord -c1 -r48000 -fS16_LE - | nc -l -u 1233 | csdr convert_i16_f | csdr gain_ff 7000 | csdr convert_f_samplerf 20833 | sudo rpitx -i - -m RF -s 48000 -f YOUR_FREQ
## Sending from Gnuradio
In Gnuradio use the block "TCP sink" and select port 8011, localhost, tcp, client<br>
Make sure the -s clock is the same as the Gnuradio<br>
nc -l 8011 | sudo /home/pi/rpitx/rpitx -i- -m IQFLOAT -s 48000 -f 145891 &<br>
The input for transmitter.<br>
## Sending IQ Stream from comand line
Usage: sendiq [-i File Input][-s Samplerate][-l] [-f Frequency] [-h Harmonic number] <br>
-i            path to File Input <br>
-s            SampleRate 10000-250000 <br>
-f float      central frequency Hz(50 kHz to 1500 MHz),<br>
-l            loop mode for file input<br>
-h            Use harmonic number <br>
-t            IQ type (i16 default) {i16,u8,float,double}<br>
-?            help (this help).<br>


## decoding the telemetry
##multimon-ng

Multimon-ng is a general purpose decoder. It can take wav or raw files and decode a variety of modes among which: CW, AFSK, FSK...
## How to CW

First you have to use sox to convert ogg files from SatNOGS download to 22050Hz raw file:
sox file.ogg -r 22050 file.raw gain 6
The gain is in dB and has a considerable impact on the decoding in the special case of CW. You have to adjust gain to get proper decoding.

Then you must apply on the raw file the proper decoder:
multimon-ng -a MORSE_CW -t raw file.raw
## How to AFSK

First convert to raw sound file (sampling frequency 22050Hz) using sox
sox -t ogg $file -r 22050 -t raw file.raw $soxopts

Then use multimon-ng with AFSK1200 decoder
multimon-ng -t raw -a AFSK1200 $file.raw

You can add more decoders if needed with additionnal "-a" options 
