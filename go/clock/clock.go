package clock

import "fmt"

// Clock represents a clock
type Clock struct {
	hours   int
	minutes int
}

// New creates a new Clock with the provided hours and minutes
func New(h, m int) Clock {
	minutes := m % 60
	hours := (h + m/60) % 24

	if minutes < 0 {
		minutes += 60
		hours--
	}

	if hours < 0 {
		hours += 24
	}

	return Clock{hours, minutes}
}

func (c Clock) String() string {
	return fmt.Sprintf("%02d:%02d", c.hours, c.minutes)
}

// Subtract subtracts an ammount of minutes from the Clock, returning a new Clock
func (c Clock) Subtract(minutes int) Clock {
	return New(c.hours, c.minutes-minutes)
}

// Add adds an ammount of minutes from the Clock, returning a new Clock
func (c Clock) Add(minutes int) Clock {
	return New(c.hours, c.minutes+minutes)
}
