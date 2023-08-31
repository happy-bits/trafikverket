// OBJECTS

const resultArea = document.querySelector(".result")
const inputEmail = document.querySelector(".email")
const inputEmailAgain = document.querySelector(".email-again")

// FUNCTIONS

function sendForm() {
    // Clean up
    resultArea.classList.remove("hidden")
    resultArea.classList.remove("success")
    resultArea.classList.remove("error")

    // Tom address
    if (inputEmail.value === ""){
        resultArea.classList.add("error")
        resultArea.innerText = "Empty email address"
        return
    }
    
    // Felaktigt format
    if (!isValidEmailAddress(inputEmail.value)) {
        resultArea.classList.add("error")
        resultArea.innerText = "Invalid email address"
        return
    }
    
    // Olika addresser
    if (inputEmail.value !== inputEmailAgain.value) {
        resultArea.classList.add("error")
        resultArea.innerText = "Not the same"
        return
    }

    resultArea.classList.add("success")
    resultArea.innerText = "Success :)" 

}   


function isValidEmailAddress(email) {
    return String(email)
        .toLowerCase()
        .match(
            /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
        ) != null;
};
