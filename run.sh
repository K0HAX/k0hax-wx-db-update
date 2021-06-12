#!/bin/sh
set -e

# crond running in foreground. log files can be retrive from /var/log/cron mount point
crond -s /var/spool/cron/crontabs -f -L /var/log/cron/cron.log "$@"

