$(document).ready =>
	# fires an ajax action when marked dropdown menus have their value changed
	$('select[remote=true]').change ->
		$.get($(this).attr('action'), $(this).serializeArray())

	# firex an ajax action when marked checkboxes are clicked
	$('input[type=checkbox][remote=true]').change ->
		checked = $(this).is(":checked")
		
		$.get($(this).attr('action'), {active : checked})

	# fires an ajax action when marked input fields have their contents updated
	$('input[remote=true]').keyup ->
		$.ajax({type: $(this).attr('method'), url: $(this).attr('action'), data: $(this).serializeArray()})
  	
	# dynamically expands text areas
	$('textarea').each ->
		$(this).autogrow({animate : false})
