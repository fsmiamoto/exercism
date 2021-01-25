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
	shouldDoubleDigit := len(digits)%2 == 0

	for i := range digits {
		parsedDigit, err := strconv.Atoi(digits[i])
		if err != nil {
			return false
		}

		if shouldDoubleDigit {
			parsedDigit = 2 * parsedDigit
			if parsedDigit > 9 {
				parsedDigit -= 9
			}
		}

		totalSum += parsedDigit
		shouldDoubleDigit = !shouldDoubleDigit
	}

	return totalSum%10 == 0
}
