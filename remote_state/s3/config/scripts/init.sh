#!/bin/bash

set -e

if [ "$1" != "" ]; then
  if [ ! -d  "./$1" ]; then
    echo '==> initialize tfstate file for' $1
    mkdir -p "./$1"
  fi
else
  echo '==> initialize root tfstate file'
fi
