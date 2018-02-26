#!/bin/bash

if [ $# -eq 0 ]
then
    echo "no version specified, usage: sh $0 1.1.4"
    exit 1
fi

VERSION=$1
FILE="sgcc-sas-jstorm-topology-topn-${VERSION}-jar-with-dependencies.jar"
if [ -f $FILE ]
then
    /opt/storm/bin/storm jar ${FILE} cn.com.sgcc.hn.topology.RollingTopServersTopology config.properties
else
    echo "$FILE is not a file"
    exit 1
fi
