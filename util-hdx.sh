#!/usr/bin/env bash
### Displays the file head and executes the chosen line, removing the first occurrence of '#' first.
### Providing NUMBER from the interval [1..9] skips the interaction and executes the given line directly.

fn_exec_header_line() {
    local readonly me="util-hdx"
    local arg1="$1"
    local number=$2
    local line=""

    if [[ $# -eq 0 ]] ; then
        echo "Displays the file head and executes the chosen line, removing the first occurrence of '#' first."
        echo "Providing NUMBER from the interval [1..9] skips the interaction and executes the given line directly."
        echo "usage: $me FILE [NUMBER]"
        return 0
    fi

    if [ ! -f "$arg1" ] ; then echo "File [$arg1] not found!" ; return -1 ; fi
    if [ $# -ge 2 ] ; then
        if [[ $number -lt 1 || $number -gt 9 ]] ; then
            echo "break"
            echo "NUMBER must be from the interval [1..9]!"
            return -1
        fi
    fi

    if [ $# = 1 ] ; then

        # output the header numbering the lines
        head $arg1 | cat -n

        read -rp $'Which line to execute? [1..9] ' -n1 key
        if [[ "$key" = '' || "$key" -lt "1" || "$key" -gt "9" ]] ; then
            # Space pressed, do something
            # echo [$key] is empty when SPACE is pressed # uncomment to trace

            echo "break"
            echo "The NUMBER must be from the interval [1..9]!"
            return 0
        else
            number=$key
        fi
        echo
    fi

    # get the command line and replace the first '#' by space
    line=$(tail -n +$number $arg1 | head -n 1)
    line=${line/'#'/}

    if [ $# = 1 ] ; then

        # display the chosen line
        echo "$line"

        read -rp $'Execute the line above? (y) ' -n1 key
        if [ "$key" != "y" ] ; then
            echo "break by user"
            return 0
        fi
        echo
    fi

    echo

    # execute the chosen line
    ($line)
}

fn_exec_header_line "$@"
