# this function will place the number of dots in a clicked attribute
# into the text field for rolling dice

dots_to_dice = (element) ->
	count = 0

	if $(element).children().length > 0
		count = $(':last-child', element).html().replace(/\s+/g, '').length
	else
		count = $(element).html().replace(/\s+/g, '').length

	if count == 0
		count = if $(element).prev().hasClass('mental') then -3 else -1

	count

count_dice = ->
	dice = ''
	dice = dice + ' + ' + dots_to_dice(attribute) for attribute in $('.count')

	# remove the leading ' + '
	dice = dice.substring(3)

	$('#dice_count').val(dice)

$(document).ready ->
  $('span.rollable').click ->
    $(this).toggleClass('counting')
    $(this).next().each (index, element) =>
      $($(element).val()).toggleClass('counting')
      $($(element).val()).next.toggleClass('counting')
      $($(element).val()).next.toggleClass('count')
    $(this).next().toggleClass('counting')
    $(this).next().toggleClass('count')

    count_dice()
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

	# clear all selected attributes and clean out
	# the value in the calculator
	$('#clear_dice').click ->
		$('td.dots_label').removeClass('counting')
		$('td.dots_number').removeClass('counting')
		$('td.dots_number').removeClass('count')

		count_dice()

