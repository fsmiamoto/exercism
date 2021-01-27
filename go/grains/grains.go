package grains

import (
	"errors"
)

// Square returns the number of grains for a given square number
// An error != nil is returned when the square number is out of the interval [1,64]
func Square(s int) (uint64, error) {
	if s < 1 || s > 64 {
		return 0, errors.New("invalid square, must be between 1 and 64 (inclusive)")
	}

	return 1 << (s - 1), nil
}

// Total returns the total number of grains the board
func Total() uint64 {
	return 1<<64 - 1
}
