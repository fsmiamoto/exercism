// This stub file contains items which aren't used yet; feel free to remove this module attribute
// to enable stricter warnings.
#![allow(unused)]

/// various log levels
#[derive(Clone, PartialEq, Debug)]
pub enum LogLevel {
    Debug,
    Info,
    Warning,
    Error,
}
/// primary function for emitting logs
pub fn log(level: LogLevel, message: &str) -> String {
    match level {
        LogLevel::Debug => debug(message),
        LogLevel::Info => info(message),
        LogLevel::Warning => warn(message),
        LogLevel::Error => error(message),
    }
}
pub fn debug(message: &str) -> String {
    String::from("[DEBUG]: ") + message
}
pub fn info(message: &str) -> String {
    String::from("[INFO]: ") + message
}
pub fn warn(message: &str) -> String {
    String::from("[WARNING]: ") + message
}
pub fn error(message: &str) -> String {
    String::from("[ERROR]: ") + message
}
