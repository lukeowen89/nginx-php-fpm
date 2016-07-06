#!/bin/bash
/bin/bash /var/www/site/scripts/setup

# Start supervisord and services
/usr/bin/supervisord -n -c /etc/supervisord.conf
