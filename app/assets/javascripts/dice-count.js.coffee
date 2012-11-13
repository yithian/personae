# this function will place the number of dots in a clicked attribute
# into the text field for rolling dice

choose = (object) ->
	$(object).toggleClass('count')
	$(object).toggleClass('selected')
	$(object).prev().toggleClass('selected')

$(document).ready ->
	$('td.dots_number').click ->
		choose(this)
		
		dice = ''
		dice = dice + ' + ' + $(attribute).html().length for attribute in $('.count')
		
		dice = dice.substring(3)
		
		$('#dice_count').val(dice)