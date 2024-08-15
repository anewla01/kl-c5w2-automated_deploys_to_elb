#!/bin/bash
# Purpose: Script for performing healthchecks on ec2 machine

# Maximum thresholds (exclusive) that should be 
CPU_UTILIZATION_THRESHOLD=60

function install_dependencies(){
  mpstat_avail=$(which mpstat)
  if [[ -z "${mpstat_avail}" ]]
  then
    sudo apt-get update
    sudo apt-get install -y sysstat
  fi
}
function get_cpu_utiliztion_pct(){
  local return_value=$(mpstat -P ALL | grep "all" | awk '{print 100 - $NF}')
  echo "${return_value}" 
}

function main(){
  install_dependencies

  local cpu_util=$(get_cpu_utiliztion_pct)
  echo "Found CPU usage: ${cpu_util}% (THREHOLD: ${CPU_UTILIZATION_THRESHOLD}%)"

  if [[ $(echo "${cpu_util} > ${CPU_UTILIZATION_THRESHOLD}" | bc) -eq 1 ]]
  then
    echo "***CPU higher than threshold***"
    exit 1
  fi
}

main
