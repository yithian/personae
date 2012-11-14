# this function will place the number of dots in a clicked attribute
# into the text field for rolling dice

count_dice = ->
		dice = ''
		dice = dice + ' + ' + $(attribute).html().length for attribute in $('.count')

		dice = dice.substring(3)

		$('#dice_count').val(dice)

$(document).ready ->
	$('td.dots_label').click ->
		$(this).toggleClass('counting')
		$(this).next().toggleClass('counting')
		$(this).next().toggleClass('count')

		count_dice()

	$('td.dots_number').click ->
		$(this).toggleClass('count')
		$(this).toggleClass('counting')
		$(this).prev().toggleClass('counting')

		count_dice()
