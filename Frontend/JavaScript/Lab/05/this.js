
// This code works fine, but it's a bit repetitive...

const button1 = document.querySelector(".button1")
const button2 = document.querySelector(".button2")
const button3 = document.querySelector(".button3")
const button4 = document.querySelector(".button4")

function changeBackground1() {
    button1.style.backgroundColor="#a7d31e"
}

function changeBackground2() {
    button2.style.backgroundColor="#a7d31e"
}

function changeBackground3() {
    button3.style.backgroundColor="#a7d31e"
}

function changeBackground4() {
    button4.style.backgroundColor="#a7d31e"
}

// This code solves the same problem but with just three lines of code!

function changeBackground(element) {

    element.style.backgroundColor="#a7d31e"

}
