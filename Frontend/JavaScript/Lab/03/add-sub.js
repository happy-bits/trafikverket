const result = document.querySelector(".result")

let number = 0

function addOne() {
    // number = number +1
    // number += 1
    number++
    result.innerHTML = number
}

function subtractOne() {

    number--
    result.innerHTML = number
    

}