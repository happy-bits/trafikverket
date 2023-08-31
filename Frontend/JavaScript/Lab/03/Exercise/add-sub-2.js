const result = document.querySelector(".result")

let number

reset()

function addOne() {
    number++
    render()
}

function addTen() {
    number+=10
    render()
}

function substractOne() {
    number--
    render()
}

function substractTen() {
    number-=10
    render()
}

function reset() {
    number = 1337
    render()
}

// alternativ
// const isOdd = number => number & 1 === 1 

function render() {
    result.innerHTML = number

    if (isOdd(number)) {
    // if (number & 1)  {
    // if (number % 2 === 1){
        result.classList.add("blue-dots")
    } else {
        result.classList.remove("blue-dots")
    }
}

function isOdd(number) {
    return number & 1 === 1
} 