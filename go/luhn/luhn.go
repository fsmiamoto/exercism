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

	// Reverse it so we start from the right
	s = reverse(s)

	// Sum everything, doubling every second digit
	totalSum := 0
	for i, d := range strings.Split(s, "") {
		digit, _ := strconv.Atoi(d)
		if i%2 == 1 {
			digit = 2 * digit
			if digit > 9 {
				digit -= 9
			}
		}
		totalSum += digit
	}

	return totalSum%10 == 0
}

func reverse(s string) string {
	runes := []rune(s)
	for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
		runes[i], runes[j] = runes[j], runes[i]
	}
	return string(runes)
}
