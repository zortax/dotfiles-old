#!/bin/bash
ps aux | grep 'gradle' | awk '{ print $2 }' | head -n1
