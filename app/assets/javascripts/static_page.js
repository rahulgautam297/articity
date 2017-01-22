$(document).ready(function(){
	var i=1;
	setInterval(function(){
		var array=["Writers","Designers", "Voice Over","Musicians","Actors","Animators"];
		$(".fadeThis").fadeOut(1000,function(){
			i=i%array.length;
			$(".fadeThis").text(array[i++]);
			$(".fadeThis").fadeIn(1000);
			});
	}, 4000);
});

