// forloop

for (let i = 5; i <= 8; i++) {
    console.log('Ett tal ' + i);
    console.log('HEJ!!!');
}

// while loop

let kalle = 5;

while (kalle <= 8) {
    console.log(kalle);
    kalle = kalle + 1;
}

// "for of"

let cities = ['Stockholm', 'Göteborg', 'New York'];

for (let x of cities) {
    console.log("Fin stad: " + x);
}

// "for of" with "break"

let cities2 = ['Stockholm', 'Göteborg', 'New York', 'Amsterdam', 'Dublin'];

// Compare with "==="

for (let x of cities2) {
    if (x === "Göteborg") {
        break;
    }
    console.log("Fin stad: " + x);

}
