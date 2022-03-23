function randomString(){
    var randomString=0;
    var possible ="dss12344ddd";
    for(var i=0;i<5;i++){
        randomString+=possible.charAt(Math.floor(Math.random()*possible.length));
    }
    
    return randomString

}