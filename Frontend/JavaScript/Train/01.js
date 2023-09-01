const result = document.querySelector(".result")
const from = document.querySelector(".from")
const to = document.querySelector(".to")
const okbutton = document.querySelector("button")

update()

function wayChange(radioGroup) {

    document.querySelectorAll(".radio-group").forEach(r => r.classList.remove("selected"))
    radioGroup.classList.add("selected")

    radioGroup.querySelector("input[type=radio]").click()

    update()
}

function getSelectedWay() {

    const checkedRadio = document.querySelector("input[type=radio]:checked")


    if (checkedRadio === null) {
        return null
    }

    return checkedRadio.id


}

function update() {

    const wayChoice = getSelectedWay()

    // Hide result text
    result.classList.add("hidden")

    // Användaren har precis kommit in på sajten

    if (wayChoice === null) {
        from.disabled = true
        to.disabled = true
        okbutton.disabled = true
    }

    // User has chosen "oneway"

    if (wayChoice === 'oneway') {

        from.disabled = false
        to.disabled = true
        okbutton.disabled = from.value === ""
    }

    // User has chosen "roundtrip" 
    if (wayChoice === 'roundtrip') {

        from.disabled = false
        to.disabled = false
        okbutton.disabled = from.value === "" || to.value === ""

        if (to.value !== "" && to.value < from.value) {
            to.value = from.value
        }
    }

}

function makeChoice() {
    // Show result text
    result.classList.remove("hidden")

    const wayChoice = getSelectedWay()

    if (wayChoice === 'oneway') {

        result.innerHTML = `You have chosen a <b>one way</b> trip at <b>${from.value}</b>`
    }

    if (wayChoice === 'roundtrip') {

        result.innerHTML = `You have chosen a <b>round trip</b> from <b>${from.value}</b> to <b>${to.value}</b>`
    }
}