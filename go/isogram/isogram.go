package isogram

import "unicode"

// IsIsogram tells if a word or phrase is a isogram, i.e does not contain any repeating letters.
// This function does not consider casing, so 'A' and 'a' are treated as equal.
func IsIsogram(text string) bool {
	seenLetters := make(map[rune]bool)

	for _, char := range text {
		// Ignore hyphens and spaces
		if char == '-' || char == ' ' {
			continue
		}

		letter := unicode.ToLower(char)

		if seenLetters[letter] {
			return false
		}

		seenLetters[letter] = true
	}

	return true
}
