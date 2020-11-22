package diffsquares

func SumOfSquares(n int) int {
	return n * (n + 1) * (2*n + 1) / 6
}

func SquareOfSum(n int) int {
	return sq(n) * sq(n+1) / 4
}

func Difference(n int) int {
	return SquareOfSum(n) - SumOfSquares(n)
}

func sq(n int) int {
	return n * n
}
