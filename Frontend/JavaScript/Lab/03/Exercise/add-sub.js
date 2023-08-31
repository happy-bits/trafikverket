const result = document.querySelector(".result")

let number

reset()

function addOne() {
    number++
    result.innerHTML = number
}

function addTen() {
    number+=10
    result.innerHTML = number
}

function substractOne() {
    number--
    result.innerHTML = number
}

function substractTen() {
    number-=10
    result.innerHTML = number
}

function reset() {
    number = 1337
    result.innerHTML = number
}
