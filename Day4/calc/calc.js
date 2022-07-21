
function addition(){
    let num1 = parseFloat(document.querySelector("#txtFirstNumber").value);
    let num2 = parseFloat(document.querySelector("#txtSecondNumber").value);


    let sum = num1 + num2;
    document.querySelector("#txtResult").value = sum;
}

let subButton = document.querySelector("#btnSubtract");
subButton.addEventListener("click", function (){
    let num1 = parseFloat(document.querySelector("#txtFirstNumber").value);
    let num2 = parseFloat(document.querySelector("#txtSecondNumber").value);
    let diff = num1 - num2;
    document.querySelector("#txtResult").value = diff;
});



function subtract(){
    let num1 = parseFloat(document.querySelector("#txtFirstNumber").value);
    let num2 = parseFloat(document.querySelector("#txtSecondNumber").value);
    let diff = num1 - num2;
    document.querySelector("#txtResult").value = diff;
}
