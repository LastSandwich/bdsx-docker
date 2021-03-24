# bdsx-docker

Running [bdsx](https://github.com/bdsx/bdsx) in a Docker container with support for plugins

## Setup

docker-compose.yaml defines where the worlds, config, backup and scripts files are located as well as the port number for the server - you will need to change these settings for your own needs and files will be created for you if they don't exist.

````
    volumes:
      - C:\Minecraft\Bdsx-Docker:/root/bds
````

## Scripts
This docker image allows you to run your own scripts before Bdsx starts up which is useful for installing plugins. The scripts folder sits in the same folder as above. 

### pre-start.sh
If you want to install any plugins, add the npm commands to pre-start.sh
Make sure the file is saved with LF line endings (`\n`)

````
npm i @bdsx/backup
````

### index.ts
If you want to run your own scripts, add your code to scripts/index.ts e.g.
````
console.log("Scripts has loaded");

import { BackupManager } from "@bdsx/backup";
import { bedrockServer } from "bdsx/launcher";

const backupManager = new BackupManager(bedrockServer);
backupManager.init({
    backupOnStart: true,
    skipIfNoActivity: true,
    backupOnPlayerConnected: true,
    backupOnPlayerDisconnected: true,
    interval: 15,
    minIntervalBetweenBackups: 5,
    bedrockServerPath: "."
}).then((res) => {
    console.log(`Backup manager initiated`);
});
````

## How to run using the docker-compose file
1. Download the files in this repository
2. Set the correct parameters for your environment
2. Open a shell to the folder
3. Run `docker-compose -f ./docker-compose.yaml up`

## Docker image
[https://hub.docker.com/r/lastsandwich/minecraft-bdsx-linux](https://hub.docker.com/r/lastsandwich/minecraft-bdsx-linux)

## Known issues

* Running the @bdsx/backup plugin in a docker environment has issues - some backups are missed, especially if not players are connected.
