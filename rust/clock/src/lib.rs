#[derive(Debug, PartialEq, Eq)]
pub struct Clock {
    hours: i8,
    minutes: i8,
}

impl Clock {
    pub fn new(hours: i32, minutes: i32) -> Self {
        Clock {
            hours: (hours + minutes.div_euclid(60)).rem_euclid(24) as i8,
            minutes: minutes.rem_euclid(60) as i8,
        }
    }

    pub fn add_minutes(&self, minutes: i32) -> Self {
        Self::new(self.hours.into(), self.minutes as i32 + minutes)
    }

    pub fn to_string(&self) -> String {
        format!("{:02}:{:02}", self.hours, self.minutes)
    }
}
