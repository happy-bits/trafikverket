function funRet1() {

    /*
        Write a method "superImportant" that returns stars and the text in capital letters.

        If it is called like this:

             let text = superImportant("Itch");
             console.log(text);

        The following should be printed:

             ****** ITCH ******
    */
}

function funRet2() {
    /*

    Modify "superImportant" so you can specify whether the text should be large or not:

        These calls:

            console.log( superImportant("Service now",true) );
            console.log( superImportant("Service now",false) );
            console.log( superImportant("What does the fox says?",false) );
            console.log( superImportant("What does the fox says?",true) );

        Should give

            ****** SERVICE NOW ******
            ****** Service now ******
            ****** What does the fox says? ******
            ****** WHAT DOES THE FOX SAYS? ******

    */
}

function funRet3() {
    /*
        Write a method "addThousand" that returns a value that adds thousen to the number 

        If it is called like this:

            let myNumber = addTillThousand(18);
            console.log (myNumber);

        The following should be printed:

            1018
    */
}

function funRet4() {
    /*

    Write a method "addNumbers" that returns the sum of two numbers

        If it is called like this:

            let summa = addNumbers (3, 4);
            console.log (sum);

        The following should be printed:

            7   
    */
}

function funRet5() {
    /*
    Write a method "isMature" that returns true or false, depending on whether the person is of age

    The following code:

         let susansAge = 22;
         let mature = isMature(susansAge);
         if (mature == true) {
             console.log ("Susan is of age");
         } else {
             console.log ("Susan is NOT of legal age");
         }

     ...should print:

         Susan is of age
    */

    /*
    Extra: create the method "isMature" in the simplest way using "=>"
    */
}

// -------- EXTRA EXERCISES -----------------------------------------

function funRetExtra1() {


    /*
    Write a method "timeUntilRetirement" that returns time to retirement.
    If you submit a value greater than 65, return 0.

    These calls:

        console.log (`Number of years to retire: ${timeUntilRetirement(43)}`);
        console.log (`Number of years to retire: ${timeUntilRetirement(43)}`);
        console.log (`Number of years to retire: ${timeUntilRetirement(20)}`);
        console.log (`Number of years to retire: ${timeUntilRetirement(68)}`);
        console.log (`Number of years to retire: ${timeUntilRetirement(100)}`);

    To print:

        Number of years to retirement: 22
        Number of years to retirement: 45
        Number of years to retirement: 0
        Number of years to retirement: 0

    */
}

function funRetExtra2() {

    /*

    In this task you will create two methods "calculateVAT" and "printProductInfo"

    The purpose is to separate logic. "calculateVAT" should not print anything but only be responsible for calculating VAT.
    
    Tip: You can let "printProductInfo" call "calculateVAT"

    This:

        printProductInfo("magazine", 1000);
        printProductInfo("restaurant visit", 1000);
        printProductInfo("flight", 1000);
        printProductInfo("falafel", 1000);
        printProductInfo("hipster beer", 1000);

    Should print:

        The VAT for a newspaper that costs SEK 1000 is SEK 60
        The VAT for a restaurant visit that costs SEK 1000 is SEK 120
        The VAT for a flight that costs SEK 1000 is SEK 60
        The VAT for a falafel that costs SEK 1000 is SEK 250
        The VAT for a hipster beer that costs SEK 1000 is SEK 250    
    
    */

}