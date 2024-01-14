use std::collections::HashMap;

pub fn frequency(input: &[&str], worker_count: usize) -> HashMap<char, usize> {
    merge_maps(calculate_indices(input.len(), worker_count)
               .iter()
               .map(|(start,end)| count(input, *start, *end)))
}

fn merge_maps<I>(iter: I) -> HashMap<char, usize>
where I: Iterator<Item = HashMap<char, usize>>
{
    let mut result: HashMap<char, usize> = HashMap::new();
    for map in iter {
        for (key, value) in map {
            *result.entry(key).or_insert(0) += value;
        }
    }
    result
}

fn count(input: &[&str], from: usize, to: usize) -> HashMap<char,usize> {
    merge_maps(input[from..to].iter().map(|s| frequency_count(s)))
}

fn frequency_count(input: &str) -> HashMap<char, usize> {
    let mut result: HashMap<char, usize> = HashMap::new();

    input.chars()
        .map(character_normalizer)
        .filter(|c| c.is_some())
        .map(|c| c.unwrap())
        .for_each(|c| *result.entry(c).or_insert(0) += 1);

    result
}

fn character_normalizer(c: char) -> Option<char> {
    if !c.is_alphabetic() {
        None
    } else {
        Some(c.to_lowercase().last().unwrap())
    }
}


fn calculate_indices(slice_len: usize, num_chunks: usize) -> Vec<(usize, usize)> {
    let mut indices = Vec::new();
    let chunk_size = slice_len / num_chunks;
    let mut start = 0;

    for _ in 0..num_chunks {
        let end = if start + chunk_size > slice_len {
            slice_len
        } else {
            start + chunk_size
        };
        indices.push((start, end));
        start = end;
    }

    // Handle any remainder by adjusting the last chunk
    if slice_len % num_chunks != 0 {
        let (last_start, _) = indices.last_mut().unwrap();
        *last_start = if slice_len - slice_len % num_chunks < *last_start {
            slice_len - slice_len % num_chunks
        } else {
            *last_start
        };
    }

    indices
}
