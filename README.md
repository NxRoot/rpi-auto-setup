# RPI - Auto Setup 
Automated tool to setup a minimal raspbian installation with some useful features.

|TFT Screen|Script Execution|Web Applications|
|--|--|--|
|<img style="width: 280px;" src="https://i.pinimg.com/originals/21/89/aa/2189aa597d68c701564159188f78ac53.jpg"/>|<img style="width: 280px;" src="https://cdn.sparkfun.com/assets/learn_tutorials/8/1/2/screen_04.png"/>|<img style="width: 280px;" src="https://i.pinimg.com/originals/d3/1d/70/d31d70178a86423619604b315f2d9984.jpg"/>|


## Features

* 💯 &nbsp;Powerful scripting and configuration tool.
* 🧬 &nbsp;Install multiple tools with a single command.
* ✍️ &nbsp;Create your own scripts to install custom tools.
* ✅ &nbsp;Host pre-configured web servers and applications.
* 🚀 &nbsp;Extremely lightweight and ultra-flexible configuration.


&nbsp;

## First Steps
<details>
  <summary> &nbsp; <b>Flash SD Card with Raspbian OS</b></summary>

1. ### &nbsp; Open [Raspberry Pi Imager](https://www.raspberrypi.com/software/)
2. ### &nbsp; Choose Device (RPI 3, 4, 400, 5)
3. ### &nbsp; Choose OS --> `Raspberry Pi OS (Other)`
4. ### &nbsp; Select `Raspbian x64 Legacy - No Desktop (0.3gb)`
5. ### &nbsp; Choose USB Storage (SD Card Drive)
6. ### &nbsp; Configure settings before flashing
    - Setup Wifi Network
    - Enable SSH
    - User: pi
    - Password: YOUR PASSWORD
</details>

<details>
  <summary> &nbsp; <b>Connect to device using SSH</b></summary>

1. ### &nbsp; Open terminal on a pc in the same network
2. ### &nbsp; Find the IP address of your RPI
    ```bash
    nslookup raspberrypi
    ```
3. ### &nbsp; Connect to RPI using SSH
    ```bash
    ssh pi@xxx.xxx.xxx
    ```

</details>

&nbsp;

## Installation

```tsx
sudo apt install -y git
sudo rm -rf ~/rpia
git clone https://github.com/NxRoot/rpi-auto-setup.git ~/rpia
sudo cp ~/rpia/install /usr/local/bin/rpia
sudo chmod +x /usr/local/bin/rpia
```

## Usage
```console
rpia --autologin=B2 --server=node --client=js --splash=off --chrome --smb --reboot
```
<details>
  <summary> &nbsp; <b>--hello</b></summary>

  #### Test Script
  ```bash
  rpia --hello
  ```
</details>

<details>
  <summary> &nbsp; <b>--splash</b></summary>

  #### Enable/Disable Splashscreen
  > This will change the config file located at: `/boot/config.txt`
  ```bash
  # Enable
  rpia --splash=on

  # Disable
  rpia --splash=off
  ```
</details>

<details>
  <summary> &nbsp; <b>--autologin</b></summary>

  #### Configure boot mode
  ```bash
  # B1 - Console
  rpia --autologin=B1

  # B2 - Console Autologin
  rpia --autologin=B2

  # B3 - Desktop
  rpia --autologin=B3

  # B4 - Desktop Autologin
  rpia --autologin=B4
  ```
</details>

<details>
  <summary> &nbsp; <b>--reboot</b></summary>

  #### Reboot after installation
  ```bash
  rpia --reboot
  ```
</details>

<details>
  <summary> &nbsp; <b>--destroy</b></summary>

  #### Remove rpia after installation
  ```bash
  rpia --destroy
  ```
</details>

<details>
  <summary> &nbsp; <b>--server</b></summary>

  #### Host REST API
  > This will host a local server running on http://localhost:5001
  ```bash
  # Node JS
  rpia --server=node

  # Python
  rpia --server=python
  ```
</details>

<details>
  <summary> &nbsp; <b>--client</b></summary>

  #### Host Web App 
  > This will add a <b>web application</b> to a server hosted by the `--server` argument.<br>
  > This can only be used after `--server`.
  
  ```bash
  # Javascript
  rpia --client=js

  # React
  rpia --client=react
  ```
</details>

<details>
  <summary> &nbsp; <b>--sherlock</b></summary>

  #### Install Sherlock OSINT
  > Please read documentation: [Sherlock](https://github.com/sherlock-project/sherlock)
  ```bash
  rpia --sherlock
  ```
</details>

<details>
  <summary> &nbsp; <b>--chrome</b></summary>

  #### Run Browser on Boot
  > You must enable <b>Console Auto-Login</b> on the Raspbian Config.
  ```bash
  # Open localhost
  rpia --chrome

  # Open specific URL
  rpia --chrome=https://youtube.com
  ```
</details>

<details>
  <summary> &nbsp; <b>--msf</b></summary>

  #### Install Metasploit Framework
  > Please read documentation: [Metasploit](https://docs.metasploit.com/docs/using-metasploit/basics/using-metasploit.html)
  ```bash
  rpia --msf
  ```
</details>

<details>
  <summary> &nbsp; <b>--smb</b></summary>

  #### Host Shared Folder with Samba
  > Please read documentation: [Samba](https://www.jeffgeerling.com/blog/2021/htgwa-create-samba-smb-share-on-raspberry-pi)
  ```bash
  rpia --smb
  ```
</details>

<details>
  <summary> &nbsp; <b>--tft</b></summary>

  #### Setup TFT Screen
  > Please read documentation to find your TFT model: [LCD-WIKI](http://www.lcdwiki.com/Main_Page)
  ```bash
  rpia --tft=MHS35
  ```
</details>

&nbsp;

## Custom
You can create your own modules using ***bash*** script.<br>
The `modules` folder contains an example script that you can use as reference.
```bash
cat ~/rpia/modules/hello/install
```
The first 3 arguments will be received in every script.<br>
- `$root` Path to home folder
- `$rpias` Path to rpia folder
- `$value` Passed in command --key=value
```bash
#!/bin/bash
root=$1
rpias=$2
value=$3
dir=$(dirname $0)

echo This is a test script
echo $root $rpias $value $dir
```

## Lets make a script to install nmap
First steps
```bash
# Go to 'modules' folder
cd ~/rpia/modules

# Copy example script to 'nmap' folder 
cp hello nmap

# Open the script with text editor
nano nmap/install
```
The script content
```bash
#!/bin/bash
root=$1
rpias=$2
value=$3
dir=$(dirname $0)

# install nmap
sudo apt install -y nmap

# print some message
echo "Successfully installed 'Nmap'"

```
Calling your script
```console
rpia --nmap
```

&nbsp;

## Documentation
<details>
  <summary> &nbsp; <b>Host REST API + UI</b></summary>

  <br>
  
  ## REST API
  > This will host a local server running on http://localhost:5001
  <details>
    <summary> &nbsp; <b>Using NodeJS</b></summary>
  
  ### Install NodeJS 
  ```bash
  curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
  sudo apt-get install -y nodejs
  ```
  
  ### Create Folder 
  ```bash
  mkdir ~/pi-server
  cd ~/pi-server
  ```
  
  ### Create Server 
  `sudo nano server.js`
  ```js
  const path = require('path')
  const express = require('express')
  const app = express()
  const PORT = 5001
  
  // serve static assets
  app.use(express.static('client/build'));
  
  // Create API endpoints
  app.get('/api/message', (req, res) => {
      res.json({message: "Hello from Express JS"})
  });
  
  // Send everything else to static content
  app.get('*', (req, res) => res.sendFile(path.resolve(__dirname, 'client/build', 'index.html')));
  
  // Open server on specified port
  console.log('Server started on port:', PORT)
  app.listen(PORT)
  ```
  
  ### Initialize Project 
  ```bash
  npm init
  ```
  
  ### Install Express JS
  ```bash
  npm i express
  ```
  
  ### Start Server
  ```bash
  npm start
  ```
  </details>
  
  <details>
    <summary> &nbsp; <b>Using Python</b></summary>
  
  ### Create Folder 
  ```bash
  mkdir ~/pi-server
  cd ~/pi-server
  ```
  
  ### Create virtual environment
  ```bash
  python3 -m venv venv
  ```
  
  ### Activate virtual environment
  ```bash
  source venv/bin/activate
  ```
  
  ### Install Flask
  ```bash
  pip install flask
  pip install python-dotenv
  ```
  
  ### Create Server
  `sudo nano server.py`
  ```py
  from flask import Flask
  
  app = Flask(__name__, static_folder='./client/build', static_url_path='/')
  
  @app.route('/', methods=['GET'])
  def index():
      return app.send_static_file('index.html')
  
  @app.route('/api/message', methods=['GET'])
  def message():
      return "Hello from Python"
  ```
  
  ### Start Server
  ```bash
  venv/bin/flask --app ./server.py run --no-debugger
  ```
  </details>
  
  <br></br>
  ## Web App
  > This will add a web application to the previously hosted server.
  <details>
    <summary> &nbsp; <b>Using Html</b></summary>
  
  ### Create Folders
  ```bash
  cd ~/pi-server
  mkdir client
  mkdir client/build
  ```
  ### Create Website
  `sudo nano client/build/index.html`
  ```html
  <!doctype html>
  <html>
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
      <h1>
        Hello world!
      </h1>
    </body>
  </html>
  ```
  </details>
  
  <details>
    <summary> &nbsp; <b>Using React</b></summary>
  
  ### Install NodeJS 
  ```bash
  curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
  sudo apt-get install -y nodejs
  ```
  ### Create React App
  ```bash
  cd ~/pi-server
  npx create-react-app client
  ```
  ### Build Website
  ```bash
  cd ~/pi-server/client
  npm run build
  ```
  </details>
  
  <br></br>

</details>


<details>
  <summary> &nbsp; <b>Sharing Files with SMB </b></summary>

  ### Create Folder 
  ```bash
  mkdir ~/shared
  sudo chmod -R 777 ~/shared
  ```
  ### Install Samba 
  ```bash
  sudo apt install -y samba samba-common-bin
  ```
  ### Config Samba ([More](https://www.jeffgeerling.com/blog/2021/htgwa-create-samba-smb-share-on-raspberry-pi))
  `sudo nano /etc/samba/smb.conf`
  ```bash
  # Add to end of file
  [shared]
  path=~/shared
  public = yes
  read only = no
  guest only = yes
  writeable = yes
  browseable = yes
  guest ok = yes
  force create mode = 0666
  force directory mode = 0777
  ```
</details>

<details>
  <summary> &nbsp; <b>Open browser on boot</b></summary>

  <br>
  
  > You must enable <b>Console Auto-Login</b> on the Raspbian Config.
  
  ### Install Chromium 
  ```bash
  sudo apt-get install --no-install-recommends xserver-xorg x11-xserver-utils xinit openbox chromium-browser
  ```
  
  ### Boot Config
  `sudo nano ~/.bash_profile`
  ```bash
  [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && startx -- -nocursor
  ```
  
  ### Start Script
  `sudo nano ~/.xinitrc`
  ```bash
  #!/usr/bin/env sh
  
  GEO="$(fbset -s | awk '$1 == "geometry" { print $2":"$3 }')"
  WIDTH=$(echo "$GEO" | cut -d: -f1)
  HEIGHT=$(echo "$GEO" | cut -d: -f2)
  
  # Hide console
  xset -dpms
  xset s off
  xset s noblank
  
  # Start browser
  chromium-browser --kiosk "http://localhost:5001" \
    --window-size=$WIDTH,$HEIGHT \
    --window-position=-10,0 \
    --start-fullscreen \
    --start-maximized \
    --kiosk \
    --incognito \
    --noerrdialogs \
    --disable-translate \
    --no-first-run \
    --fast \
    --fast-start \
    --use-gl=none \
    --autoplay-policy=no-user-gesture-required \
    --disable-infobars \
    --disable-features=TranslateUI \
    --disk-cache-dir=/dev/null \
    --overscroll-history-navigation=0 \
    --disable-pinch \
    --enable-kiosk-mode \
    --enabled \
    --disable-java \
    --disable-restore-session-state \
    --disable-sync --disable-translate \
    --disable-touch-drag-drop \
    --disable-touch-editing \
    --test-type \
    --ignore-certificate-errors \
    --no-sandbox
  
  ```
</details>

<details>
  <summary> &nbsp; <b>Setup TFT Screen</b></summary>

  <br>

  > Please read documentation for your TFT model: [LCD-WIKI](http://www.lcdwiki.com/Main_Page)
  
  ### Install GIT 
  ```bash
  sudo apt install -y git
  ```
  
  ### Install TFT Drivers
  ```bash
  git clone https://github.com/goodtft/LCD-show.git
  chmod -R 755 LCD-show
  cd LCD-show/
  sudo ./MHS35-show
  sudo reboot
  ```
</details>

<br></br>
