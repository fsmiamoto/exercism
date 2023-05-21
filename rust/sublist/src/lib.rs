#[derive(Debug, PartialEq, Eq)]
pub enum Comparison {
    Equal,
    Sublist,
    Superlist,
    Unequal,
}

pub fn sublist<T: PartialEq>(first_list: &[T], second_list: &[T]) -> Comparison {
    if first_list.len() == second_list.len() {
        // Same size, check if they're equal
        return if equal(first_list, second_list) {
            Comparison::Equal
        } else {
            Comparison::Unequal
        };
    }
    // Sizes are different
    if first_list.len() < second_list.len() {
        return if is_sublist(first_list, second_list) {
            Comparison::Sublist
        } else {
            Comparison::Unequal
        };
    }
    return if is_sublist(second_list, first_list) {
        Comparison::Superlist
    } else {
        Comparison::Unequal
    };
}

fn is_sublist<T: PartialEq>(first: &[T], second: &[T]) -> bool {
    return second.iter().enumerate().any(|(i, _)| {
        let end = if (i + first.len()) < second.len() {
            i + first.len()
        } else {
            second.len()
        };
        return equal(first, &second[i..end]);
    });
}

fn equal<T: PartialEq>(first: &[T], second: &[T]) -> bool {
    if first.len() != second.len() {
        return false;
    }
    return first.iter().zip(second).all(|(x, y)| x == y);
}
