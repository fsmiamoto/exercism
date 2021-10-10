const BASE_HOURLY_RATE: u64  = 221;

pub fn production_rate_per_hour(speed: u8) -> f64 {
    let raw_rate = BASE_HOURLY_RATE * speed as u64;

    let success_rate = match speed {
        0..=4 => 1.0,
        5..=8 => 0.9,
        9..=10 => 0.77,
        _ => panic!("Invalid speed"),
    };

    return success_rate * raw_rate as f64;
}

pub fn working_items_per_minute(speed: u8) -> u32 {
    production_rate_per_hour(speed) as u32 / 60
}
