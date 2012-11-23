# this function will place the number of dots in a clicked attribute
# into the text field for rolling dice

dots_to_dice = (element) ->
	count = 0;
	
	if $(element).children().length > 0
		count = $(':last-child', element).html().replace(/\s+/g, '').length
	else
		count = $(element).html().replace(/\s+/g, '').length
	
	if count == 0
		count = -1

		count = -3 if $(element).prev().hasClass('mental')
	
	count

count_dice = ->
	dice = ''
	dice = dice + ' + ' + dots_to_dice(attribute) for attribute in $('.count')

	# remove the leading ' + '
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
