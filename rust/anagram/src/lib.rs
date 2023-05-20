use std::collections::HashSet;

pub fn anagrams_for<'a>(word: &str, possible_anagrams: &[&'a str]) -> HashSet<&'a str> {
    let normalized_word = normalize(word);
    possible_anagrams
        .iter()
        .filter(|&w| is_anagram(w,&normalized_word))
        .cloned()
        .collect()
}

fn normalize(input: &str) -> String {
    input.to_lowercase()
}

fn is_anagram(word: &str, normalized_word: &str) -> bool {
    let normalized = normalize(word);
    normalized != normalized_word && sort(&normalized) == sort(normalized_word)
}

fn sort(input: &str) -> String {
    let mut chars: Vec<char> = input.chars().collect();
    chars.sort_unstable();
    chars.into_iter().collect()
}
