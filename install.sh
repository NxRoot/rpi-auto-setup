#!/bin/sh

echo
echo RPI Auto-Setup
echo

# Root folder
root=/home/pi
# Setup folder
rpias=$(pwd)

# Iterate arguments
for arg in "$@"; do

    # check if arg starts with --
    if [ "${arg#--}" != "$arg" ]; then

        key="${arg%%=*}"
        value="${arg#*=}"

        # Install TFT
        if [ $key = "--tft" ]; then
            if [ $key != $value ]; then
                echo [Installing] $key
                sudo rm -rf $root/LCD-show
                cd $root
                git clone https://github.com/goodtft/LCD-show.git
                chmod -R 755 LCD-show
                cd LCD-show/
                sudo ./$value-show
            else
                echo 
                echo [$key] missing value: $key=MHS35
                echo 
                exit 1
            fi
        fi

        # Install Node JS
        if [ $key = "--node" ]; then
            if [ $key != $value ]; then
                echo [Installing] $key
                cd $rpias
                curl -fsSL https://deb.nodesource.com/setup_$value.x | sudo -E bash -
                sudo apt-get install -y nodejs
                sudo npm install -g npm
            else
                echo 
                echo [$key] argument is missing value: $key=20
                echo 
                exit 1
            fi
        fi

        # Install REST API
        if [ $key = "--rest" ]; then
            if [ $key != $value ]; then
                if [ $value = "node" ]; then
                    echo [Installing] $key

                    sudo rm -rf $root/pi-server
                    mkdir $root/pi-server

                    cd $rpias
                    cat _node.txt >> $root/pi-server/server.js
                    cd $root/pi-server
                    npm init -y
                    npm i express

                    file=/etc/rc.local
                    search="exit 0"
                    a="cd $root/pi-server"
                    b="npm start"

                    # Remove exit 0
                    sudo ex -s +"g/$search/d" -cwq $file

                    aE=$(grep -Fxq "$a" $file)
                    bE=$(grep -Fxq "$b" $file)

                    if $aE && $bE; then
                        sudo ex -s +"g/$a/d" -cwq $file
                        sudo ex -s +"g/$b/d" -cwq $file
                    fi

                    # Cut lines
                    total_lines=$(wc -l < "$file")
                    lines_to_keep=$((total_lines - 1))
                    head -n "$lines_to_keep" "$file" > "$file.tmp" && mv "$file.tmp" "$file"

                    # Append lines
                    sudo echo $a >> $file
                    sudo echo $b >> $file
                    sudo echo $search >> $file
                fi
            else
                echo 
                echo [$key] argument is missing value: $key=node
                echo 
                exit 1
            fi
        fi

        # Install Samba
        if [ $key = "--smb" ]; then
            echo [Installing] $key
            sudo rm -rf $root/shared
            cd $rpias
            mkdir $root/shared
            sudo chmod -R 777 $root/shared
            sudo apt install -y samba samba-common-bin
            sudo cat _smb.txt >> $root/.xinitrc
        fi

        # Install Chromium
        if [ $key = "--chrome" ]; then
            echo [Installing] $key

            cd $rpias
            sudo apt-get install --no-install-recommends xserver-xorg x11-xserver-utils xinit openbox chromium-browser -y
            sudo cat _bash.txt >> $root/.bash_profile
            sudo cat _xinit.txt >> $root/.xinitrc
        fi

    else
        echo 
        echo "Unknown argument: $arg"
        echo 
        exit 1
    fi
done

echo
echo [Completed] RPI Auto-Setup
echo
echo Device will reboot now...
echo

# sleep 5000
# sudo reboot
