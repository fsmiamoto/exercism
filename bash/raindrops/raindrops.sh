#!/usr/bin/env bash

is_divisible_by() {
  return $(($2%$1))
}

result=""

if is_divisible_by 3 $1; then
  result+="Pling"
fi

if is_divisible_by 5 $1; then
  result+="Plang"
fi

if is_divisible_by 7 $1; then
  result+="Plong"
fi

echo ${result:-$1}
