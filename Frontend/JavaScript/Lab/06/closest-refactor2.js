
const checkAll = button => checkboxes(button).forEach(child => child.checked = true )

const uncheckAll = button => checkboxes(button).forEach(child => child.checked = false )

const toggleAll = button => checkboxes(button).forEach(child => child.checked = !child.checked )

function countAll(button) {
    
    const nrOfChecked = checkboxes(button).filter(child => child.checked).length

    if (nrOfChecked == 0) {
        console.log("No checked :(")
    } else {
        console.log(`Number of checked: ${nrOfChecked}`)
    }
}

function checkboxes(button) {
    return Array.from(button.closest(".mama").children).filter(child => child.tagName != "DIV")
}
