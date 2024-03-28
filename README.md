# MidnightGhostHuntServer
This guide details the method of creating a Midnight Ghost Hunt Dedicated server via Linux, Docker, or Pterodactyl.

## General Info
In order to host the dedicated server in a non-windows environment, a translation layer must be utilized. This guide uses wine64 to act as the translation layer.

The Midnight Ghost Hunt Server is a windows application (rather than a console), which means an X11 server and display is required. The video layer created does not actually output anything, so this guide utilizes the package xvfb, which acts as a virtual video buffer. All video information is dumped into the buffer.  
> This guide utilizes Wine64 as the translation layer, and xvfb as the virtual video buffer.

#### Note: I do not provide a method for downloading the server. Steam64 can be used however you must provide your steam account username and password in plaintext, and 2fa must be off or you must manually install the server. I recommend manually uploading the files to the server.

## Linux
When running the servers baremetal, it is recommended to use daemon tool such as "screen" to separate the console instance from the terminal or user shell. This will allow you to continue using the primary terminal or shell instance, without having to open a new instance of the shell.

Addendum: It's been a while since I last worked on this project but I will try to explain from memory what I did. I may not dive as deep into topics, so you will probably have to do a decent amount of research on your own.
Execute the actions in the Dockerfile for installing critical dependencies. Once the wine environment is setup, just install the visual studio redistributable once. After that the server should be able to start bare metal. Make sure to set the appropriate environmental variables. (Specifically for the virtual video buffer and wine environment)


## Docker
The dockerfile attached should allow for quick installation. It is designed for pterodactyl but can be modified to run directly via docker. Mounts and files may have to be added manually.
The build time is pretty long but it is because it has to pull many things and build some stuff manually iirc. Idk why I did it like this, but I think it was tricky getting it to work for whatever reason (ParkerVCP please make a better egg than mine dear god).

## Pterodactyl

The egg provided should work fine. You may need to manually create the dockerfile and post it. My current dockerfile is private but I will make it public if possible.
