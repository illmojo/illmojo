#!/bin/bash

# Way to use bash. mojotoitu:
cmdsBashrc[0]="alias l='ls -lah'"
cmdsBashrc[1]="alias 'cd..'='cd ..'"


for cmd in "${cmdsBashrc[@]}"
do
  cutted=$(echo "$cmd" | cut -d "=" -f1)"="
  if grep -q "$cutted" ~/.bashrc
  then
    echo "${cutted} #found, so not inserted to .bashrc"
  else
    echo "${cutted} #not found, so IS inserted to .bashrc"
    $(echo "${cmd}" >> ~/.bashrc)
  fi
done

# light came & light went
echo "lets turn off the lights"
echo 0 | sudo tee /sys/class/leds/led1/brightness > /dev/null
echo 0 | sudo tee /sys/class/leds/led0/brightness > /dev/null

if grep -q "\/sys\/class\/leds\/led0\/brightness" /etc/rc.local
  then
    echo "very dark already exists 0"
  else
    sudo sed -i -e '$i \sudo echo 0 | sudo tee /sys/class/leds/led0/brightness > /dev/null\n' /etc/rc.local
fi

if grep -q "\/sys\/class\/leds\/led1\/brightness" /etc/rc.local
  then
    echo "very dark already exists 1"
  else
    sudo sed -i -e '$i \sudo echo 0 | sudo tee /sys/class/leds/led1/brightness > /dev/null\n' /etc/rc.local
fi
echo "leds off"
