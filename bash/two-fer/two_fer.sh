#!/usr/bin/env bash

if [[ "$1" = "" ]]; then
  echo "One for you, one for me."
  exit 0;
fi

echo "One for $1, one for me."
