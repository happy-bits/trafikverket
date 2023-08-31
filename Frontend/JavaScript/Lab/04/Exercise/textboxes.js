const text1 = document.querySelector(".text1")
const text2 = document.querySelector(".text2")

const resultFirst = document.querySelector(".result-first")
const resultSecond = document.querySelector(".result-second")

render()

function render() {

    if (isNumeric(text1.value)) {
        resultSecond.innerText = parseFloat(text1.value) * 1000
    } else {
        resultSecond.innerText = "No number :("
    }
    
    text2.value = text1.value
    
    const nrOfChars = text1.value.length

    if (nrOfChars === 0) {
        resultFirst.innerHTML = "No characters :("
    } else if (nrOfChars === 1) {
        resultFirst.innerHTML = nrOfChars + " character"
    } else {
        resultFirst.innerHTML = nrOfChars + " characters"
    }

}

function isNumeric(str) {
    if (typeof str != "string")
        return false
    return !isNaN(str) && !isNaN(parseFloat(str))
}