#!/bin/bash

set -e

readonly TODO_DIRECTORY="${TODO_DIRECTORY:-"${HOME}/Documents/todo"}"
readonly TODO_EDITOR="${EDITOR}"

readonly TODO_FILE="$(date +%Y-%m-%d).md"
readonly TODO_PATH="${TODO_DIRECTORY}/${TODO_FILE}"


if [ ! -d "${TODO_DIRECTORY}" ]; then
    while true; do
        printf "%s does not exist, do you want to create it? (y/n) " "${TODO_DIRECTORY}"
        read -r yn

        case "${yn}" in
            [Yy]* ) mkdir -p "${TODO_DIRECTORY}"; break;;
            [Nn]* ) exit;;
            * ) printf "Please answer y or n\n\n";;
        esac
    done
fi

if [ ${#} -eq 0 ]; then
    if [ -p "/dev/stdin" ]; then
        (cat; printf "\n") >> "${TODO_PATH}"
    else
        cal -m > "/tmp/mycal"
        LC_ALL=ru_RU.utf8 date +"ToDo: %d %B, %Y" > "/tmp/mytodo.lst"
        echo "====================="  >> "/tmp/mytodo.lst"
        cat "${TODO_DIRECTORY}/${TODO_FILE}"  >> "/tmp/mytodo.lst"
        paste "/tmp/mycal" "/tmp/mytodo.lst"
    fi
else
    printf "%s\n" "${*}" >> "${TODO_PATH}"
    cal -m > "/tmp/mycal"
    LC_ALL=ru_RU.utf8 date +"ToDo: %d %B, %Y" > "/tmp/mytodo.lst"
    echo "=====================" >> "/tmp/mytodo.lst"
    cat "${TODO_DIRECTORY}/${TODO_FILE}"   >> "/tmp/mytodo.lst"
    paste "/tmp/mycal" "/tmp/mytodo.lst"
fi


