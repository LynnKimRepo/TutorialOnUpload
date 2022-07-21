const body = document.body;
body.append("hello", " world"); 


let div = document.createElement("div");
div.innerText = "Hello world";

let strong = document.createElement("strong");
strong.innerText= "Another string";


body.append(div);
body.append(strong);



let stro = document.querySelector("strong");
stro.style.color = "blue";

let p = document.createElement("p");
p.innerHTML = "<span> Hello I am inside a P>Span tag </span>";
body.append(p);

let pVar = document.querySelector("span");
pVar.classList.add("newClass");


function toggle(element){
    let variable = element.nextElementSibling;
    if(variable.classList.contains("newClass")){
        variable.classList.remove("newClass");
    }
    else{
        variable.classList.add("newClass");
    }
}