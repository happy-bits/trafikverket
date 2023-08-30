// A function

function läggTillTre(x) {
    let result = x + 3;
    console.log(result);
}

// A function

function iLikeData() {
    console.log("------- JAG GILLAR DATA! ------");
}

// A function with parameters

function iLikeDataWithBorder(addBorder) {
    if (addBorder) {
        console.log("-------------------------------");
    }
    console.log("------- JAG GILLAR DATA! ------");

    if (addBorder) {
        console.log("-------------------------------");
    }
}

// A function with multiple parameters

function iLikeDataWithBorderAndRepeat(addBorder, borderChar) {
    if (addBorder) {
        console.log(borderChar.repeat(31));
    }

    console.log(borderChar + "       JAG GILLAR DATA!      " + borderChar);

    if (addBorder) {
        console.log(borderChar.repeat(31));
    }
}

// An array as a parameter

function skrivUtListan(arr) {

    console.log("EN LISTA!");
    for (let x of arr) {
        console.log("* " + x);
    }
}

// "includes" and "toUpperCase"

function television(x) {
    if (["SVT1", "SVT2", "TV4"].includes(x.toUpperCase()))
        console.log("I know that channel");
    else
        console.log("What?");
}




