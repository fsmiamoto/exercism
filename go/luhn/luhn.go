package luhn

import (
	"strconv"
	"strings"
)

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

	// Parse digits into a slice
	parsedDigits := make([]int, len(s))
	for _, digit := range strings.Split(s, "") {
		d, _ := strconv.Atoi(digit)
		parsedDigits = append(parsedDigits, d)
	}

	// Double every second digit, starting from the right
	shouldDouble := false
	for i := len(parsedDigits) - 1; i >= 0; i-- {
		if !shouldDouble {
			shouldDouble = true
			continue
		}

		doubledDigit := 2 * parsedDigits[i]
		if doubledDigit > 9 {
			doubledDigit -= 9
		}
		parsedDigits[i] = doubledDigit
		shouldDouble = false
	}

	// Sum everything up
	totalSum := 0
	for i := range parsedDigits {
		totalSum += parsedDigits[i]
	}

	return totalSum%10 == 0
}
