#!/bin/bash -x
# Author: Kun Huang <academicgareth@gmail.com>

echo "Hello, scalpels ci"
sca setup -d /opt/stack/data/scalpels/scripts

# debug messages
sudo netstat -nltp
sudo ps axf
sudo env
env

echo start three agents
sca start -a rpc -a rabbit -a traffic

echo "running load"
source /opt/stack/new/devstack/openrc admin admin
sca load --storm
sleep 10

echo stop those agents
sca stop

echo waiting agent write data into db before report
sleep 20

echo report data
sca report

echo result data
sca result --list
