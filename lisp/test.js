function newAdd() {
    var a = 1;
    var b = 2;
    var c = a + b;
}

var obj = {
    add : function (){
	newAdd();
    },
    concat: function () {
	var s1 = "Hello";
	var s2 = "World";
	var s3 = s1 + s2;
    },

    fun2 : function (){
	this.concat();
    }
};

function sayHello(name){
    console.log("Hello" + name);
}
