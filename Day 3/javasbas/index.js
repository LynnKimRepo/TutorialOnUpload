

var i = 0;
console.log(i + " i")
i = true;
console.log(i + " i")
i = "adfasdF";
console.log(i + " i")

let j = 1234;
console.log(j + " j")
j = false;
console.log(j + " j")
j = "poiqwe";
console.log(j + " j")

/*
Number (int, decimals)
Strings
Boolean
null
undefined
NaN (is a number type but is different as it is not a number)
Symbol
*/

let numval = 1;
let stringval = "1";
console.log(numval == stringval);

//we must use three equal signs to check for identity and data type
console.log(numval === stringval);

let nullvar = null;
let undefvar = undefined;

console.log(typeof(nullvar));
console.log(typeof(undefvar));

let x = 1000;
x = null;
console.log(typeof(x));

let nan = 0/"i";
console.log(nan);

console.log(100 + "200"); //100200
console.log(100 - "200"); //-100
console.log(100 + true); //101

//inherit boolean values:
//truthy and falsey values:
/*
0, "", null, undefined, NaN, false : false
every else: true
*/

if(x){}else{} //would go to else because x is null in this example
if(1000){}

//C# cw($"{variable}")
//js `dfdfsfd ${variable} ` 

for(let i = 0; i < 10; i++){

}

switch(true){
    case true:
        console.log("very true");
    case false:
        console.log("not true at all");
}

let arr = ["string", 12, true, false, null, [123, false, null], undefined];
console.log(arr[100]);

arr[100] = "Um i kinda skipped some numbers";
console.log(arr.length);

/*
.pop: removes from the end, you can aso pop(index) to remove item at that index
.push: adds at end
.shift: remove first
.unshift: add to the beginning
*/

let student = {
    name: "brad",
    grades: [
        firstyear = 55,
        secondyear= 76
    ],
    year: "junior 2022",
    perfectAtt: false
}

console.log(student.year);
for(let item in student){
    console.log(item);
}


function shout(){
    console.log("HI");
    e = 10;
}

let global = 0;
function add(a , b){
    console.log(a+ b);
    let t = "Tee";
    let global = 15;
    i = 10;
    shout();
}
//console.log(t);// reference error

//Typescript : a super set of javascript where it is more tightly coupled where you specify the data type to force errors.

//Local scopes: scoping accord to the context given and limits usage outside context: 
//ex: variables that are defined in the context disppears outside and does nto affect outside ie. let

//global scoping: variables can be used and influenced regardless of local scope ie. var

//lexical/functional scoping: 


function addthree(a, b ,c){
    let d = a + b +c;
    addAnother(10);
    function addAnother(e){
        let sum = d + e;
    }

    //console.log(sum); //reference error

    //cannot use sum
    //we cannot use inner function content for the outer function
}
addthree(1, 2, 3);


//Closure: is when an inner function access a variable outside the scope.


//a reference error: console.log(a + " a") because a was used before declaration
let a = 10;
//console.log(a + " a")


shout();

console.log(e + " e");
var e = 11;
// console.log(e + " e");

//dont use var. is global scope and also hoists up the implementation to the top, then you know you are very error prone.

let powerOne = x => {
    return x * x;
}

powerOne(x);