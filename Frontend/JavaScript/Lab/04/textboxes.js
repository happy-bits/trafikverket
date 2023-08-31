const text1 = document.querySelector(".text1")
const text2 = document.querySelector(".text2")
const result = document.querySelector(".result")

//result.innerText = "No characters :("

render()

function render() {

    text2.value = text1.value

    const nrOfChars = text1.value.length

    if (nrOfChars === 0){
        result.innerText = "No characters :("
    } else if (nrOfChars === 1){
        result.innerText = nrOfChars + " character"
    } else {
        result.innerText = nrOfChars + " characters"
    }

}