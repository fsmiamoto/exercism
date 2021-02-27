package clock

import "fmt"

// Clock represents a clock
type Clock struct {
	minutes int
}

// New creates a new Clock with the provided hours and minutes
func New(h, m int) Clock {
	minutes := m + h*60
	minutes %= 24 * 60
	if minutes < 0 {
		minutes += 24 * 60
	}
	return Clock{minutes}
}

func (c Clock) String() string {
	return fmt.Sprintf("%02d:%02d", c.minutes/60, c.minutes%60)
}

// Subtract subtracts an ammount of minutes from the Clock, returning a new Clock
func (c Clock) Subtract(minutes int) Clock {
	return New(c.minutes/60, (c.minutes%60)-minutes)
}

// Add adds an ammount of minutes from the Clock, returning a new Clock
func (c Clock) Add(minutes int) Clock {
	return New(c.minutes/60, (c.minutes%60)+minutes)
}
