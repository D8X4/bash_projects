#! /bin/bash

cd ~/Scripts
journalctl -b > bootlog.log
grep -i error bootlog.log > booterrors.log
rm bootlog.log
mv booterrors.log ~/Desktop
