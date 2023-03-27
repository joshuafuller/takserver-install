#!/bin/bash

# Define the command to be scheduled in cron
CRON_COMMAND="0 0 * * * /opt/tak/certs/autorenewal.sh"

# Write the command to a temporary file
echo "${CRON_COMMAND}" > /tmp/cronjob

# Add the command to the user's crontab
crontab /tmp/cronjob

# Remove the temporary file
rm /tmp/cronjob
