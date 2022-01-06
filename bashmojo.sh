#!/bin/bash

# Way to use bash. mojotoitu:
cmdsBashrc[0]="alias l='ls -lah'"
cmdsBashrc[1]="alias 'cd..'='cd ..'"
cmdsBashrc[2]="alias p=\"cal && echo '' && date '+%A %x' && date '+%X'\""

for cmd in "${cmdsBashrc[@]}"
do
  cutted=$(echo "$cmd" | cut -d "=" -f1)"="
  if [[ $(grep "$cutted" ~/.bashrc ~/.bash_aliases | sed 's/^ *//g' | grep -v '^#') ]]
  then
    echo -e "$cutted \t\t #found, so not inserted to .bash_aliases"
  else
    echo -e "$cutted \t\t #not found, so IS inserted to .bash_aliases"
    $(sudo echo "$cmd" >> ~/.bash_aliases)
  fi
done

# light came & light went
echo ""
echo "lets turn off the lights"
echo 0 | sudo tee /sys/class/leds/led1/brightness > /dev/null
echo 0 | sudo tee /sys/class/leds/led0/brightness > /dev/null

if grep -q "\/sys\/class\/leds\/led0\/brightness" /etc/rc.local
  then
    echo "very dark already exists 0"
  else
    sudo sed -i '/^exit 0/i sudo echo 0 | sudo tee /sys/class/leds/led0/brightness > /dev/null\n' /etc/rc.local
fi

if grep -q "\/sys\/class\/leds\/led1\/brightness" /etc/rc.local
  then
    echo "very dark already exists 1"
  else
    sudo sed -i '/^exit 0/i sudo echo 0 | sudo tee /sys/class/leds/led1/brightness > /dev/null\n' /etc/rc.local
fi
echo "leds off"
