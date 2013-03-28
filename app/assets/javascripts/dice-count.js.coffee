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

get_value = (element) ->
  console.log($(element).text())
  if $.isNumeric($(element).text())
    $(element).text()
  else
    dots_to_dice(element)

count_dice = ->
	dice = ''
	dice = dice + ' + ' + get_value(attribute) for attribute in $('.count')

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

    # clear all selected attributes and clean out
    # the value in the calculator
  $('#clear_dice').click ->
    $('td.dots_label').removeClass('counting')
    $('td.dots_number').removeClass('counting')
    $('td.dots_number').removeClass('count')
    count_dice()

  $('span.rollable').click ->
    $(this).next().contents().not('.no_count').each (index, element) =>
      if $.isNumeric($(element).text())
        $(element).toggleClass('count')
      else
        $('body').find('#' + $(element).text().toLowerCase()).toggleClass('counting')
        $('body').find('#' + $(element).text().toLowerCase()).prev().toggleClass('counting')
        $('body').find('#' + $(element).text().toLowerCase()).toggleClass('count')
    count_dice()

