

function checkAll(button) {

    for (let child of checkboxes(button)) {
        child.checked = true
    }
}

function uncheckAll(button) {

    for (let child of checkboxes(button)) {
        child.checked = false
    }
}

function toggleAll(button) {

    for (let child of checkboxes(button)) {
        child.checked = !child.checked
    }
}


function countAll(button) {

    let nrOfChecked = 0

    for (let child of checkboxes(button)) {
        if (child.checked) {
            nrOfChecked++
        }
    }

    if (nrOfChecked == 0) {
        console.log("No checked :(")
    } else {
        console.log(`Number of checked: ${nrOfChecked}`)
    }
}


function checkboxes(button) {
    return Array.from(button.closest(".mama").children).filter(child => child.tagName != "DIV")
}
