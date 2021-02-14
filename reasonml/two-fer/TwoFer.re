let twoFer = (name) => {
    switch(name) {
        | None => "One for you, one for me"
        | Some(name) => "One for " ++ name ++ ", one for me."
    }
}
