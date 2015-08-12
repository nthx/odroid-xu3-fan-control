# odroid-xu3-fan-control
Makes Odroid XU3 Lite fan silent on idle load

## Odroid XU3 Lite

Will only work on:
* *Ubuntu 14.04.1*
* Arch Linux (3.10.69-1-ARCH)

Was not tested anywhere else. Might work though after adjusting script variables

## Precautions

### Only *Odroid XU3 Lite* is supported

Users report it *does not* work on XU4

### Is it safe to use?

I did my best to adjust fan speed based on current *maximum* temperature of any sensor.

Also, when script quits it brings fan mode back to *automatic* "factory" settings.

I use and will use this software. But in the end - if anything happens to your hardware, do not blame me please.

## Usage

    sudo apt-get install git
    git clone https://github.com/nthx/odroid-xu3-fan-control.git
    cd odroid-xu3-fan-control
    sudo ./odroid-xu3-fan-control.sh

## Installation

To make it start when system boots:

edit odroid-fan-controller and add the path of the odroid-xu3-fan-control.sh script (full-pathname), then do the following to add it
to the runlevels

    cd /etc/init.d/
    #adjust to correct, absolute path below
    sudo ln -s ~/odroid-xu3-fan-control/odroid-fan-controller
    sudo update-rc.d odroid-fan-controller defaults

you can also use the following to start the controller

    sudo /etc/init.d/odroid-fan-controller start

or

    sudo /etc/init.d/odroid-fan-controller stop

to stop the controller
