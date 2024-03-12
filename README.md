# [WIP] RPI - Auto Setup
Commands to setup a minimal raspbian installation with some useful features.


|<img style="width: 300px;" src="https://i.pinimg.com/originals/48/e1/a0/48e1a037a65cf8208f841ab5fccd1ab8.jpg"/>|<img style="width: 300px;" src="https://cdn.sparkfun.com/assets/learn_tutorials/8/1/2/screen_04.png"/>|
|--|--|

# First Steps
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
    - User: Pi
    - Password: YOUR PASSWORD
</details>

<details>
  <summary> &nbsp; <b>Connect to device using SSH</b></summary>

1. ### &nbsp; Open terminal on a pc in the same network
2. ### &nbsp; Find the IP address of your RPI (Windows)
    ```bash
    nslookup raspberrypi
    ```
3. ### &nbsp; Connect to RPI using SSH
    ```bash
    ssh pi@xxx.xxx.xxx
    ```

</details>


### Update RPI
```bash
sudo apt update
```

### Raspbian Config
```bash
sudo raspi-config
```
<details>
  <summary> &nbsp; <b>Enable Console Auto-Login</b></summary>

1.  ### &nbsp; Choose --> `System Options`
2.  ### &nbsp; Choose --> `Boot / Auto Login`
3.  ### &nbsp; Choose --> `Console Autologin`
4.  ### &nbsp; Choose --> `Finish`
</details>

<br></br>

# Installation

### Install GIT 
```bash
sudo apt install -y git
```
### Clone Repo
```bash
git clone https://github.com/NxRoot/rpi-auto-setup.git
cd rpi-auto-setup
```


# Usage
### Available options
```bash
sudo sh install --rest=node --chrome --smb --tft=MHS35
```
<details>
  <summary> &nbsp; <b>Setup TFT Screen</b></summary>

<br>

Select your TFT model
```bash
sudo sh install --tft=MHS35
```
</details>

<br></br>
# Manual Installation
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
  mkdir /home/pi/pi-server
  cd /home/pi/pi-server
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
  mkdir /home/pi/pi-server
  cd /home/pi/pi-server
  ```
  
  ### Create virtual environment
  ```bash
  python3 -m venv .venv
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
  cd /home/pi/pi-server
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
  cd /home/pi/pi-server
  npx create-react-app client
  ```
  ### Build Website
  ```bash
  cd /home/pi/pi-server/client
  npm run build
  ```
  </details>
  
  <br></br>

</details>


<details>
  <summary> &nbsp; <b>Sharing Files with SMB </b></summary>

  ### Create Folder 
  ```bash
  mkdir /home/pi/shared
  sudo chmod -R 777 /home/pi/shared
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
  path=/home/pi/shared
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
  `sudo nano /home/pi/.bash_profile`
  ```bash
  [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && startx -- -nocursor
  ```
  
  ### Start Script
  `sudo nano /home/pi/.xinitrc`
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
<br></br>
