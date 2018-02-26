#!/bin/bash

jps -lm | grep org.apache.storm.daemon.nimbus | awk '{print $1}' | xargs kill -9
