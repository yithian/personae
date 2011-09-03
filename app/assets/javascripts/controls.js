$(document).ready(function() {
  // fires an ajax action when marked dropdown menus have their value changed
  $('select[remote=true]').change(function() {
    $.get($(this).attr('action'), $(this).serializeArray());
  });

  // fires an ajax action when marked input fields have their contents updated
  $('input[remote=true]').keyup(function() {
    $.ajax({
	  type: 'PUT',
	  url: $(this).attr('action'),
	  data: $(this).serializeArray()
	});
  });
  
  // dynamically expands text areas
  $('textarea').elastic();
});
