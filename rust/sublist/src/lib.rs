#[derive(Debug, PartialEq, Eq)]
pub enum Comparison {
    Equal,
    Sublist,
    Superlist,
    Unequal,
}

pub fn sublist<T: PartialEq>(first: &[T], second: &[T]) -> Comparison {
    use Comparison::*;
    match (first.len(), second.len()) {
        (m, n) if m == n => {
            if contained_in(first, second) {
                Equal
            } else {
                Unequal
            }
        }
        (m, n) if m < n => {
            if contained_in(first, second) {
                Sublist
            } else {
                Unequal
            }
        }
        (m, n) if m > n => {
            if contained_in(second, first) {
                Superlist
            } else {
                Unequal
            }
        }
        (_, _) => Unequal,
    }
}

fn contained_in<T: PartialEq>(first: &[T], second: &[T]) -> bool {
    first.is_empty() || second.windows(first.len()).any(|w| w == first)
}
