# odroid-xu3-fan-control
Makes Odroid XU3 Lite / XU4 fan silent on idle load

## Odroid XU3 Lite

Will only work on:
* *Ubuntu 14.04.1*
* Arch Linux (3.10.69-1-ARCH)

Was not tested anywhere else. Might work though after adjusting script variables

## Precautions

### *Odroid XU3 Lite* and *Odroid XU4* are supported

I only poses and test myself on XU3 Lite
Users report it works on XU4

### Is it safe to use?

I did my best to adjust fan speed based on current *maximum* temperature of any sensor.

Also, when script quits it brings fan mode back to *automatic* "factory" settings.

I use and will use this software. But in the end - if anything happens to your hardware, do not blame me please.

## Usage

    sudo apt-get install git
    mkdir -p /home/odroid/
    git clone https://github.com/nthx/odroid-xu3-fan-control.git
    cd odroid-xu3-fan-control/
    sudo ./odroid-xu3-fan-control.sh

## Installation

To make it start when system boots:

    cd /etc/init.d/
    sudo ln -s /home/odroid/odroid-xu3-fan-control/odroid-fan-controller
    sudo update-rc.d odroid-fan-controller defaults

To start manually

    sudo /etc/init.d/odroid-fan-controller start

To stop manually

    sudo /etc/init.d/odroid-fan-controller stop

