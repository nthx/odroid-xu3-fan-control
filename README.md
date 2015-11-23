# odroid-xu3-fan-control
Makes Odroid XU3 Lite / XU4 fan silent on idle load

## Odroid XU3 Lite

Will only work on:
* *Ubuntu 14.04.1*, *Ubuntu 15.04*
* Arch Linux (3.10.69-1-ARCH)

Was not tested anywhere else. Might work though after adjusting script variables

## Precautions

### *Odroid XU3 Lite* is supported

I only own Odroid XU3 Lite and test this device only

### Odroid XU4

Some users report it works on XU4. *Some users report it doesn't*. Use at your own risk (@see Issues)

### Is it safe to use?

I did my best to adjust fan speed based on current *maximum* temperature of any sensor.

Also, when script quits it brings fan mode back to *automatic* "factory" settings.

I use and will use this software. But in the end - if anything happens to your hardware, do not blame me please.

## Usage

    sudo apt-get install git
    mkdir -p /home/odroid/
    cd /home/odroid/ #make sure you can write to this directory; otherwise update paths below
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

