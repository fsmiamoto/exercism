#!/usr/bin/env bash

is_divisible_by() {
  return $(($1%$2))
}

result=""

if is_divisible_by $1 3; then
  result+="Pling"
fi

if is_divisible_by $1 5; then
  result+="Plang"
fi

if is_divisible_by $1 7; then
  result+="Plong"
fi

if [[ "$result" = "" ]]; then
  echo $1
else
  echo "$result"
fi
