#!/bin/bash

# Loud fan control script to lower speed of fun based on current
# max temperature of any cpu
#
# See README.md for details.

#set to false to suppress logs
DEBUG=true

# Make sure only root can run our script
if (( $EUID != 0 )); then
   echo "This script must be run as root:" 1>&2
   echo "sudo $0" 1>&2
   exit 1
fi


TEMPERATURE_FILE="/sys/devices/10060000.tmu/temp"
FAN_MODE_FILE="/sys/devices/odroid_fan.14/fan_mode"
FAN_SPEED_FILE="/sys/devices/odroid_fan.14/pwm_duty"
TEST_EVERY=3 #seconds
new_fan_speed_default=80
LOGGER_NAME=odroid-xu3-fan-control

#make sure after quiting script fan goes to auto control
function cleanup {
  ${DEBUG} && logger -t $LOGGER_NAME "event: quit; temp: auto"
  echo 1 > ${FAN_MODE_FILE}
}
trap cleanup EXIT

current_max_temp=`cat ${TEMPERATURE_FILE} | cut -d: -f2 | sort -nr | head -1`
echo "fan control started. Current max temp: ${current_max_temp}"
echo "For more logs see:"
echo "sudo tail -f /var/log/syslog"

while [ true ];
do
  echo 0 > ${FAN_MODE_FILE} #to be sure we can manage fan

  current_max_temp=`cat ${TEMPERATURE_FILE} | cut -d: -f2 | sort -nr | head -1`
  ${DEBUG} && logger -t $LOGGER_NAME "event: read_max; temp: ${current_max_temp}"

  new_fan_speed=0
  if (( ${current_max_temp} >= 75000 )); then
    new_fan_speed=255
  elif (( ${current_max_temp} >= 70000 )); then
    new_fan_speed=200
  elif (( ${current_max_temp} >= 68000 )); then
    new_fan_speed=130
  elif (( ${current_max_temp} >= 66000 )); then
    new_fan_speed=70 
  elif (( ${current_max_temp} >= 63000 )); then
    new_fan_speed=65 
  elif (( ${current_max_temp} >= 60000 )); then
    new_fan_speed=60
  elif (( ${current_max_temp} >= 58000 )); then
    new_fan_speed=50
  elif (( ${current_max_temp} >= 55000 )); then
    new_fan_speed=30
  else
    new_fan_speed=2
  fi
  ${DEBUG} && logger -t $LOGGER_NAME "event: adjust; speed: ${new_fan_speed}"
  echo ${new_fan_speed} > ${FAN_SPEED_FILE}

  sleep ${TEST_EVERY}
done
