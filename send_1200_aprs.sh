sudo modinfo snd-aloop
#cat aprs_telemetry.txt | minimodem --tx --tx-carrier --alsa=plughw:Loopback,0,0 1200 
cat aprs_telemetry.txt | minimodem --tx 1200
#cat aprs_telemetry.txt | minimodem --tx --tx-carrier  1200
