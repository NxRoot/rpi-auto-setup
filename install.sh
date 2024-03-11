#!/bin/sh

echo
echo RPI Auto-Setup
echo

# Root folder
root=/home/pi
# Setup folder
rpias=$(dirname "$0")
# update device
sudo apt update

# Iterate arguments
for arg in "$@"; do

    key="${arg%%=*}"
    value="${arg#*=}"

    # Set root folder
    if [ $key = "path" ]; then
        if [ $key != $value ]; then
            $root=$value
            cd $root
        else
            echo 
            echo [$key] missing value: $key=$root
            echo 
        fi
    fi
    
    # Install TFT
    if [ $key = "tft" ]; then
        if [ $key != $value ]; then
            echo [Installing] $key...
            cd $root
            sudo apt install -y git
            git clone https://github.com/goodtft/LCD-show.git
            chmod -R 755 LCD-show
            cd LCD-show/
            sudo ./$value-show
        else
            echo 
            echo [$key] missing value: $key=MHS35
            echo 
        fi
    fi

    # Install GIT
    if [ $key = "git" ]; then
        echo [Installing] $key...
        cd $rpias
        sudo apt install -y git
    fi

    # Install Node JS
    if [ $key = "node" ]; then
        if [ $key != $value ]; then
            echo [Installing] $key...
            cd $rpias
            curl -fsSL https://deb.nodesource.com/setup_$value.x | sudo -E bash -
            sudo apt-get install -y nodejs
        else
            echo 
            echo [$key] argument is missing value: $key=20
            echo 
        fi
    fi

    # Install Samba
    if [ $key = "smb" ]; then
        echo [Installing] $key...
        cd $rpias
        mkdir /home/pi/shared
        sudo chmod -R 777 /home/pi/shared
        sudo apt install -y samba samba-common-bin
        sudo cat _smb.txt >> /.xinitrc
    fi

    # Install Chromium
    if [ $key = "chrome" ]; then
        echo [Installing] $key...

        cd $rpias
        sudo apt-get install --no-install-recommends xserver-xorg x11-xserver-utils xinit openbox chromium-browser -y
        sudo cat _bash.txt >> $root/.bash_profile
        sudo cat _xinit.txt >> /.xinitrc
    fi

done

echo
echo [Completed] RPI Auto-Setup
echo
