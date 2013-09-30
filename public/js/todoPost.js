$(document).ready(function(){
	$("#trigger").click(function(){
		$("#todoForm").toggle("fast");
	});

	$(".updateTrigger").click(function(){
		console.log("test");
		$(this).parent().children("#updateForm").toggle("fast");
	});

});
