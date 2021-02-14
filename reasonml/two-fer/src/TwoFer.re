let buildMsgFor = (name) => {
    "One for " ++ name ++ ", one for me."
}

let twoFer = (name) => {
    switch(name) {
        | None => buildMsgFor("you")
        | Some(name) =>  buildMsgFor(name)
    }
}

