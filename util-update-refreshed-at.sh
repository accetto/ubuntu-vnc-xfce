#!/usr/bin/env bash
### Updates the REFRESHED_AT environment variable to the current date

searchdir="$(dirname $0)"
refreshDate=$(date +%Y-%m-%d)

find $searchdir -type f -name 'Dockerfile*' | while read file ; do \
    sed -i -e "s/^ENV REFRESHED_AT.*/ENV REFRESHED_AT $refreshDate/" $file  \
    && echo -e "replace ENV REFRESHED_AT with '$refreshDate' in file $file" ;
done
