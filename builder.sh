#!/bin/bash
### @accetto, August 2021

docker_hub_connect() {

    if [ -n "${DOCKERHUB_USERNAME}" ] && [ -n "${DOCKERHUB_PASSWORD}" ] ; then

        echo "Logging-in on Docker Hub..."
        echo "${DOCKERHUB_PASSWORD}" | docker login -u "${DOCKERHUB_USERNAME}" --password-stdin
        if [ ! $? ] ; then
            echo "Docker Hub login failed"
            return 1
        fi
    else
        echo "Local pushing requires Docker Hub login."
        echo "However, your environment does not provide required authentication data."
        return 1
    fi

    return 0
}

main() {

    local tag=${1?Need tag}
    local cmd=${2?Need command}

    local last_line
    local test_result

    case "${cmd}" in

        build | test )

            ./hooks/"${cmd}" "${tag}"
            ;;

        push )
            
            docker_hub_connect

            if [ $? -eq 0 ] ; then

                ### push to Docker Hub
                ./hooks/"${cmd}" "${tag}"

                docker logout

            else

                echo "Unable to connect to Docker hub!"
            fi
            ;;

        all )

            echo
            echo "------------------"
            echo "--> Building image"
            echo "------------------"
            echo

            ./hooks/build "${tag}"

            if [ $? -eq 0 ] ; then

                echo
                echo "---------------------------"
                echo "--> Testing version sticker"
                echo "---------------------------"
                echo

                ### test version sticker
                test_result=$( hooks/test "${tag}" 2>&1 | tail -n5  )

                echo "${test_result}"
                echo

                last_line=$(echo "${test_result}" | tail -n1)

                if [ "${last_line}" == '+ exit 0' ] ; then

                    docker_hub_connect

                    if [ $? -eq 0 ] ; then

                        echo
                        echo "-------------------------"
                        echo "--> Pushing to Docker Hub"
                        echo "-------------------------"
                        echo

                        hooks/push "${tag}"

                        docker logout

                        echo
                        echo "Refreshing README..."

                        ./utils/util-refresh-readme.sh

                    else

                        echo "Unable to connect to Docker hub!"
                    fi

                else
                    echo "Version sticker has changed. Adjust 'env' hook and refresh README using 'util-refresh-readme.sh'. Use 'test' command for details."
                fi
            fi
            ;;

        *)
            echo "Unknown command: ${cmd}"
            ;;
    esac
}

main $@
