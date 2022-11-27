#!/bin/bash
### @accetto, November 2022

### This script updates version sticker badges in README files.
### The script is intended for local use before publishing the repository.

main() {
    local searchdir="${1:-../docker}"

    local readme_path
    local env_file 
    local sticker_lines
    local sticker_label
    local sticker_value

    local -a folder_list
    local -a arr

    ### name of the updated result file
    local scrap_readme="scrap_readme.md"
    local updated_readme

    if [[ ! -d "${searchdir}" ]] ; then
        echo "Folder '${searchdir}' not found!"
        exit 1
    fi

    cd "${searchdir}"
    searchdir="$(pwd)"

    ### process only folders containing 'README.md'
    folder_list=$(find "${searchdir}" -type f -name "README.md")

    for readme_file in ${folder_list[@]} ; do

        readme_path="$(dirname ${readme_file})"
        env_file="${readme_path}/hooks/env"

        if [[ -f "${env_file}" ]] ; then

            echo -e "==> ${readme_path}\n"

            sticker_lines=$(grep -E '^\s*VERSION_STICKER_[A-Z]+=.+' "${env_file}")

            updated_readme="${readme_path}/${scrap_readme}"
            cp "${readme_file}" "${updated_readme}"

            for sticker_line in ${sticker_lines} ; do

                arr=(${sticker_line//'='/' '})

                sticker_label=${arr[0]}

                sticker_value=${arr[1]}
                sticker_value=${sticker_value//'"'/}
                eval sticker_value=${sticker_value}

                echo -e "${sticker_label}=${sticker_value}"

                ### if using 'shields.io' static badges
                # sed -i "s/^\s*\(\[badge\-${sticker_label}\][^&]*\&[^=]*=\)\([^&]*\)/\1${sticker_value}/" "${updated_readme}"
                ### if using 'badgen.net' static badges
                sed -i "s/^\s*\(\[badge\-${sticker_label}\]:\s*https:\/\/[^/]*\/badge\/[^/]*\/\)\([^/]*\)/\1${sticker_value}/" "${updated_readme}"
            done
            echo
        fi
    done
}

main $@
