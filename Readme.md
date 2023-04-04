# TUMLAB UPDATE SYSTEM

## Content
* [Prerequisites](#Prerequisites)
* [Description](#Description)
* [How to use](#How-to-use)

## Prerequisites
-   unzip
-   initializer file in the patch archive

## Description
This bash file installs several patches that remain in a zipped TUMLAB folder using an initializer file named init.sh, which should be zipped in a folder named "p+patch number" example: "p1"

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
