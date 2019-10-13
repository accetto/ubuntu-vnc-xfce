#!/bin/bash
### @accetto, October 2019

### This script updates version sticker badges in README files.
### The script is intended for local use before publishing the repository.

### where to start processing
searchdir=$1
searchdir=${searchdir:-..}

if [[ ! -d ${searchdir} ]] ; then
    echo "Folder '${searchdir}' not found!"
    exit 1
fi

cd ${searchdir}
searchdir=$(pwd)

### process only folders containing 'README.md' and 'hooks/env' files
find "${searchdir}" -type f -name "README.md" | while read readme_file ; do \

    dir="$(dirname ${readme_file})"
    env_file="${dir}/hooks/env"

    if [[ -f "${env_file}" ]] ; then

        echo "${dir}"

        sticker_lines=$(grep -E '^\s*VERSION_STICKER_[A-Z]+="[^$]+' "${env_file}")
        echo "${sticker_lines}"

        for sticker_line in ${sticker_lines} ; do

            arr=(${sticker_line//'='/' '})
            sticker_label=${arr[0]}
            sticker_value=${arr[1]}
            sticker_value=${sticker_value//'"'/}

            ### if using 'shields.io' static badges
            # sed -i "s/^\s*\(\[badge\-$sticker_label\][^&]*\&[^=]*=\)\([^&]*\)/\1$sticker_value/" "$readme_file"
            ### if using 'badgen.net' static badges
            sed -i "s/^\s*\(\[badge\-${sticker_label}\]:\s*https:\/\/[^/]*\/badge\/[^/]*\/\)\([^/]*\)/\1${sticker_value}/" "${readme_file}"
        done
    fi
done
