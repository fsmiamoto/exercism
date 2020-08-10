package hamming

import "errors"

// Distance calculates the Hamming Distance between two DNA strands
func Distance(a, b string) (int, error) {
	// Convert strings to []rune for correct Unicode comparison
	ar, br := []rune(a), []rune(b)

	if len(ar) != len(br) {
		return 0, errors.New("strands have different lengths")
	}

	distance := 0
	for i := 0; i < len(ar); i++ {
		if ar[i] != br[i] {
			distance++
		}
	}

	return distance, nil
}
