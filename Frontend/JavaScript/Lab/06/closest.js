// KODA HÄR

function checkAll(button) {

    const mama = button.closest(".mama")

    // console.log(mama)

    // console.log(mama.children)

    for(let child of mama.children){
        if (child.tagName !== "DIV"){
            child.checked = true
        }

    }
}

function uncheckAll(button) {

    const mama = button.closest(".mama")

    for(let child of mama.children){
        if (child.tagName != "DIV"){
            child.checked=false
        }
    }
}

function toggleAll(button) {

    const mama = button.closest(".mama")

    for(let child of mama.children){
        if (child.tagName != "DIV"){
            child.checked=!child.checked
        }
    }
}

function countAll(button) {

    const mama = button.closest(".mama")

    let nrOfChecked=0

    for(let child of mama.children){
        if (child.tagName != "DIV"){
            if (child.checked) {
                nrOfChecked++
            }
        }
    }

    if (nrOfChecked == 0){
        console.log("No checked :(")
    } else {
        console.log(`Number of checked: ${nrOfChecked}`)
    }
}