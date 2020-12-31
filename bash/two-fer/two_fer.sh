#!/usr/bin/env bash

other="you"

if (( $# )); then
  other="$1"
fi

echo "One for $other, one for me."

