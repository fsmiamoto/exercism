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

	// Check if there's only digits
	if _, err := strconv.Atoi(s); err != nil {
		return false
	}

	totalSum := 0

	// Sum everything, doubling every second digit starting from the right
	digits := strings.Split(s, "")
	for i := len(digits) - 1; i >= 0; i-- {
		parsedDigit, _ := strconv.Atoi(digits[i])
		if (len(digits)-i)%2 == 0 {
			parsedDigit = 2 * parsedDigit
			if parsedDigit > 9 {
				parsedDigit -= 9
			}
		}
		totalSum += parsedDigit
	}

	return totalSum%10 == 0
}
