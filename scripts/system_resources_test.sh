#!/bin/bash
# Purpose: Script for performing healthchecks on ec2 machine

# Maximum thresholds (inclusive) that should be 
CPU_UTILIZATION_THRESHOLD=60

function install_dependencies(){
  mpstat_avail=$(which mpstat)
  if [[ -z "${mpstat_avail}" ]]
  then
    sudo apt-get update
    sudo apt-get install -y sysstat
  fi
}
function get_free_cpu_utiliztion_pct(){
  local return_value=$(mpstat -P ALL | grep "all" | awk '{print $NF}')
  echo "Free CPU pct: $return_value"
}

function main(){
  install_dependencies
}

# main
