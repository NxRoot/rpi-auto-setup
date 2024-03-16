const { exec } = require("child_process")
const path = require('path')
const express = require('express')
const fs = require('fs')
const app = express()
const PORT = 5001

// serve up production assets
app.use(express.static('client/build'));

function getConfig(){
    try {
        const data = fs.readFileSync("config.json", "utf-8");
        return JSON.parse(data)
    } catch (error) {
        console.log("Error reading file:", error);
        return null
    }
}
let config = getConfig()


// get app config
app.get('/api/config', (req, res) => {
    config = getConfig()
    res.json(config)
});

// test endpoint
app.get('/api/message', (req, res) => {
    res.json({message: "Hello from Express JS"})
});

// execute commands
app.get('/api/command', (req, res) => {
    if(req.query.cmd) {
        exec(req.query.cmd.split("'")[1], (error, stdout, stderr) => {
            if (error) {
                console.error(`exec error: ${error.message}`);
                return res.json({message: error.message})
            }
            console.log(`stdout: ${stdout}`)
            return res.json({message: stdout})
        })
    }
});


// Send everything else to static content
app.get('*', (req, res) => res.sendFile(path.resolve(__dirname, 'client/build', 'index.html')));

// Open server on specified port
console.log('Server started on port:', PORT)
app.listen(PORT)