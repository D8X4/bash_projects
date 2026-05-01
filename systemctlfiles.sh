#! /bin/bash

systemctl > systemctl.log && grep "tmpfiles" systemctl.log > tmpfiles.log && mv tmpfiles.log ~/Desktop && rm systemctl.log && notify-send -t 5000 "Systemctl Operation" "Complete"
