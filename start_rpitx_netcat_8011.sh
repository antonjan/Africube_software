#rpitx v1
#nc -l 8011| sudo rpitx -i - -m IQFLOAT -f 145825 
#nc -l 8011| sudo rpitx -m RF -i- -f 145825
while true; do (nc -l 8011; dd if=/dev/zero bs=4096 count=30); done | sudo rpitx -i- -m IQFLOAT -s 250000 -f 145825 