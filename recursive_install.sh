#!/bin/bash

recursive_install() {
  echo "entering ${1}"
  echo "target ${2}"

  for file in $1; do
    if [ -f "$file" ]; then
      echo "file: ${file}"
      echo "installing into ${2}/${file} with permissions ${3}"
      install -D -m ${3} $file $2/$file
    elif [ -d "${file}" ]; then
      echo "directory : ${file}"
      recursive_install "${file}/*" "${2}" "${3}"
    else
      echo "not recognized : ${file}"
    fi
  done
}

recursive_install "${1}" "${2}" "${3}"
