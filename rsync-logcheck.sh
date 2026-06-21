#!/bin/bash

COPY_SERVER=worm
COPY_LOCATION=/opt/pt_remote/logcheck/

TARGET_LOCATION=/etc/logcheck/

RSYNC_COMMAND=$(rsync --checksum --human-readable --archive --verbose --compress --progress --stats --info=flist0,stats0,progress0 $COPY_SERVER:$COPY_LOCATION $TARGET_LOCATION)

if [ $? -eq 0 ]; then
    # Success do some more work!

    if [ -n "${RSYNC_COMMAND}" ]; then
        # rsync has changes
        echo -e "Logcheck updated\n\n"
        echo "${RSYNC_COMMAND}"
    #else
        # No changes were made by rsync
    fi
else
    echo -e "Rsync failed\n\n"
    echo "${RSYNC_COMMAND}"
    exit 1
fi
