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
        let is_sublist = second_list.iter().enumerate().any(|(i,_)| {
           let end = if (i+first_list.len()) < second_list.len() { i+first_list.len()} else {second_list.len()};
            return equal(first_list, &second_list[i..end])
        });
        return if is_sublist { Comparison::Sublist } else { Comparison::Unequal};
    }

    let is_superlist = first_list.iter().enumerate().any(|(i,_)| {
        let end = if (i+second_list.len()) < first_list.len() { i+second_list.len()} else {first_list.len()};
        return equal(second_list, &first_list[i..end])
    });

    return if is_superlist { Comparison::Superlist } else { Comparison::Unequal };
}

fn equal<T: PartialEq>(first: &[T], second: &[T]) -> bool {
    if first.len() != second.len() {
        return false;
    }

    return first.iter().zip(second).all(|(x, y)| x == y);
}
