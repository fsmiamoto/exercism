package luhn

import (
	"strconv"
	"strings"
)

// Valid reports if a string is valid using the Luhn algorithm
func Valid(s string) bool {
	// Remove whitespace
	s = strings.ReplaceAll(s, " ", "")

	if len(s) < 2 {
		return false
	}

	digits := strings.Split(s, "")

	// Sum everything, doubling every second digit starting from the right
	totalSum := 0
	double := len(digits)%2 == 0

	for _, d := range digits {
		digit, err := strconv.Atoi(d)
		if err != nil {
			return false
		}

		if double {
			digit *= 2
			if digit > 9 {
				digit -= 9
			}
		}

		totalSum += digit
		double = !double
	}

	return totalSum%10 == 0
}
