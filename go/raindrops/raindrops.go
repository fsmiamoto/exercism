package raindrops

import (
	"strconv"
	"strings"
)

type conversion struct {
	factor int
	sound  string
}

var factorToSound = []conversion{
	{3, "Pling"},
	{5, "Plang"},
	{7, "Plong"},
}

// Convert takes an integer and returns a string composed of sounds related to the factors
// of that integer
func Convert(n int) string {
	var result strings.Builder

	for _, c := range factorToSound {
		if n%c.factor == 0 {
			result.WriteString(c.sound)
		}
	}

	if result.String() == "" {
		return strconv.Itoa(n)
	}

	return result.String()
}
