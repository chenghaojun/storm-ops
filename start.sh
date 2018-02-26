#!/bin/bash

export CLUSTER_CONF_DIR=/home/sgcc/storm/conf
export STORM_CONF_DIR=/home/sgcc/storm/conf
nohup storm --config /home/sgcc/storm/conf/storm.yaml nimbus > ~/storm-nimbus.log 2>&1 &
