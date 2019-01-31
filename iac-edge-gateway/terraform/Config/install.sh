#!/usr/bin/env bash
#
#  Purpose: BootStrap Install Script
#  Usage:
#    install.sh

echo "bootscript initiated" > /tmp/results.txt

sudo apt-get update -y

echo "bootscript done" >> /tmp/results.txt
exit 0
