# MidnightGhostHuntServer
This guide details the method of creating a Midnight Ghost Hunt Dedicated server via Linux, Docker, or Pterodactyl.

## General Info
In order to host the dedicated server in a non-windows environment, a translation layer must be utilized. This guide uses wine64 to act as the translation layer.

The Midnight Ghost Hunt Server is a windows application (rather than a console), which means an X11 server and display is required. The video layer created does not actually output anything, so this guide utilizes the package xvfb, which acts as a virtual video buffer. All video information is dumped into the buffer.  
> This guide utilizes Wine64 as the translation layer, and xvfb as the virtual video buffer.

## Linux
When running the servers baremetal, it is recommended to use daemon tool such as "screen" to separate the console instance from the terminal or user shell. This will allow you to continue using the primary terminal or shell instance, without having to open a new instance of the shell.

## Docker


## Pterodactyl
