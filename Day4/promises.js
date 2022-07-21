// Callbacks: is essentially a function passed as a parameter into another function

//Promises: is a callback function to initialize a process that can either result in a resolve or reject
// resolve means it worked
// reject means it failed

//both could be like a "return" but the order matters because it can be either or but not both as a result of a promise


function demo(){
    let p = new Promise(function(resolve, reject){
        let dept = {
            id :1,
            name: "IT"
        }
        reject("service Unavailable");
    })
    p.then(function(d){

        console.log(d);
        //console.log(d.id + " " +d.name);

    })
}
demo();

let p2 = new Promise((resolve, reject) => {
    resolve(2);
})
p2.then(function(q){
    console.log(q);
    return q * 2;
}).then(function(w){
    console.log(w);
    return w * 2;
}).then(function(e){
    console.log(e);
})

let colorChange = (color, time) =>{
    return new Promise((resolve, reject)=> {
        setTimeout(() => {
            document.body.style.backgroundColor = color;
            
        }, time)
        resolve();
    })
} 

colorChange("red", 1000).then(function(){colorChange("orange", 2000)})
.then(function(){colorChange("yellow", 3000)}).then(function(){colorChange("green", 4000)})
.then(function(){colorChange("blue", 5000)}).then(function(){colorChange("purple", 6000)});


fetch("http://jsonplaceholder.typicode.com/posts").then(function(response){
    return response.json()}
).then(function(data){
    let length = data.length;
    console.log(length);
    let tblbody = document.querySelector("tbody");
    tblbody.innerHTML="";
    for(let i = 0; i< length; i++){
        let tr = `<tr><td> ${data[i].id} </td> <td> ${data[i].title} </td> <td> ${data[i].body} </td> </tr>`;
        tblbody.innerHTML = tblbody.innerHTML + tr;
    }
})