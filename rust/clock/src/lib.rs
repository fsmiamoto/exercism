#[derive(Debug, PartialEq, Eq)]
pub struct Clock {
    hours: i8,
    minutes: i8,
}

impl Clock {
    pub fn new(hours: i32, minutes: i32) -> Self {
        let trimmed_minutes = minutes.rem_euclid(60) as i8;
        let extra_hours = ((minutes as f64) / 60.0).floor() as i32;
        Clock {
            hours: (hours + extra_hours).rem_euclid(24) as i8,
            minutes: trimmed_minutes,
        }
    }

    pub fn add_minutes(&self, minutes: i32) -> Self {
        Self::new(self.hours.into(), self.minutes as i32 + minutes)
    }

    pub fn to_string(&self) -> String {
        format!("{:0>2}:{:0>2}", self.hours, self.minutes)
    }
}
