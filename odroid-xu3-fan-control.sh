#!/bin/bash

# Loud fan control script to lower speed of fun based on current
# max temperature of any cpu
#
# works only on XU3 Lite with Ubuntu 14.04.1

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
speed_fan_to_default=80

#make sure after quiting script fan goes to auto control
function cleanup {
  logger -t $0 "fan-control quiting. Setting fan to auto"
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
  logger -t $0 "current_max_temp: ${current_max_temp}"

  if (( ${current_max_temp} >= 75000 )); then
    speed_fan_to=255
  elif (( ${current_max_temp} >= 70000 )); then
    speed_fan_to=200
  elif (( ${current_max_temp} >= 68000 )); then
    speed_fan_to=130
  elif (( ${current_max_temp} >= 66000 )); then
    speed_fan_to=70 
  elif (( ${current_max_temp} >= 63000 )); then
    speed_fan_to=65 
  elif (( ${current_max_temp} >= 60000 )); then
    speed_fan_to=60
  elif (( ${current_max_temp} >= 55000 )); then
    speed_fan_to=50
  elif (( ${current_max_temp} >= 53000 )); then
    speed_fan_to=30
  else
    speed_fan_to=2
  fi
  echo ${speed_fan_to} > ${FAN_SPEED_FILE}

  sleep ${TEST_EVERY}
done
