const result = document.querySelector(".result")

/*
   Alternative

   const result = document.querySelector("#my-result")
   const result = document.getElementById("my-result")

*/

function changeHtml() {
    result.innerHTML = "What does the <b>fox</b> says?"
}

function changeText() {    
    result.innerText = "What does the <b>fox</b> says?"
}

function highlight() {
    // result.classList.add("fat-borders")
    // result.classList.add("big-orange-font")

    result.classList.add(
        "big-orange-font", 
        "fat-borders"
    )
}

function unHighlight() {

    result.classList.remove(
        "big-orange-font", 
        "fat-borders"
    )
}

function hide() {
    // result.style.visibility = "hidden";
    result.classList.add("hidden")
}

function show() {
    result.classList.remove("hidden")
}

