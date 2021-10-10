const BASE_HOURLY_RATE: u64  = 221;

pub fn production_rate_per_hour(speed: u8) -> f64 {
    let rate = success_rate_for_speed(speed);
    return (speed as u64 * BASE_HOURLY_RATE) as f64 * rate;
}

pub fn working_items_per_minute(speed: u8) -> u32 {
    let per_minute = production_rate_per_hour(speed) / 60 as f64;
    per_minute.floor() as u32
}

fn success_rate_for_speed(speed: u8) -> f64 {
    if speed >= 1 && speed <= 4 {
        return 1.0
    }
    if speed >= 5 && speed <= 8 {
        return 0.9
    }
    if speed >= 9 && speed <= 10 {
        return 0.77
    }
    return 0.0
}
