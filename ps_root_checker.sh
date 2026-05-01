#!/bin/bash
ps aux | grep 'root' | grep -vE "\[|grep" | awk '{print $2, $11}'
