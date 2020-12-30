#!/usr/bin/env bash

result="One for "

if (( $# )); then
  result+="$1"
else
  result+="you"
fi

result+=", one for me."

echo $result

