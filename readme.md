# TUMLAB UPDATE SYSTEM

## Content
* [Prerequisites](#Prerequisites)
* [Description](#Description)
* [How to use](#How-to-use)

## Prerequisites
-   unzip
-   initializer file in the patch archive

## Description
This bash file installs various patches left in a TUMLAB zipped folder using an initializer file named init.sh

## How to use

-   Clone this repo:
    ```
    git clone https://github.com/TalentumLAB/tumlab_update_system.git
    ```
-   Change executable file permissions
    ```
    chmod +x updater.sh
    ```
-   Create a crontab to validate updates at a given time interval
