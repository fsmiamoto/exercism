#!/usr/bin/env bash

if (( $# != 1 )); then
  echo "Usage: $(basename $0) <person>"
  exit 1
fi

echo "Hello, $1"
