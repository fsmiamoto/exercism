package diffsquares

// SumOfSquares calculates the sum of the square of the first n positive integers - 1,2,3...
func SumOfSquares(n int) int {
	return n * (n + 1) * (2*n + 1) / 6
}

// SquareOfSum calculates the square of the sum of the first n positive integers - 1,2,3...
func SquareOfSum(n int) int {
	return sq(n) * sq(n+1) / 4
}

// Difference calculates the difference between the square of the sum and the
// sum of the square of the first n positive integers - 1,2,3..
func Difference(n int) int {
	return SquareOfSum(n) - SumOfSquares(n)
}

func sq(n int) int {
	return n * n
}
