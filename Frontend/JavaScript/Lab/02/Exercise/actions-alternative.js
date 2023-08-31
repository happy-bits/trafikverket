const result = document.querySelector(".result")

function changeHtml() {
    clear()
    result.innerHTML = "What does the <b>fox</b> says?"
}

function changeText() {
    clear()
    result.innerText = "What does the <b>fox</b> says?"
}

function highlight() {
    clear()
    // result.classList.add("fat-borders")
    // result.classList.add("big-orange-font")

    result.classList.add(
        "big-orange-font", 
        "fat-borders"
    )
}

function unHighlight() {
    clear()
    // result.classList.remove("fat-borders")
    // result.classList.remove("big-orange-font")

    result.classList.remove(
        "big-orange-font", 
        "fat-borders"
    )
}

function hide() {
    result.classList.add("hidden")
}

function show() {
    result.classList.remove("hidden")
}

function secret() {
    clear()
    result.innerHTML = "The <b>secret</b> of the fox"
}

function ancient() {
    clear()
    result.innerHTML = "<b>Ancient</b> mystery"
    result.classList.add("fat-borders")
}

function snowFox() {
    clear()
    //result.classList = "result"
    // result.className="result"
    result.classList.add("fox")
    result.innerHTML=""
}

function clear(){
    result.classList = "result"
    result.innerHTML=""
}