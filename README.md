# odroid-xu3-fan-control
Makes Odroid XU3 Lite fan silent on idle load

## Odroid XU3 Lite

Will only work on *Ubuntu 14.04.1*. Was not tested anywhere else. 

Might work though after adjusting script variables

## Safety

I did my best to adjust fan speed based on current *maximum* temperature of any sensor.

Also, when script is quit it setups fan mode to *automatic* "factory" settings.

I use and will use this software. But in the end - if anything happens to your hardware, do not blame me please.

## Usage

    sudo apt-get install git
    git clone https://github.com/nthx/odroid-xu3-fan-control.git
    cd odroid-xu3-fan-control
    sudo ./odroid-xu3-fan-control.sh
    
