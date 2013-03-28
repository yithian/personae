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

set_roll_type = ->
  if $('.roll_type.active').size() == 0
    $('#reroll_10').prop('checked', true)
    $('#cancel').prop('checked', false)
  $('.roll_type.active').each (index, element) =>
    if $(element).text() == '9-again'
      $('#reroll_9').prop('checked', true)
    else if $(element).text() == '8-again'
      $('#reroll_8').prop('checked', true)
    else if $(element).text() == 'rote'
      $('#reroll_rote').prop('checked', true)
    else
      $('#reroll_10').prop('checked', true)

    if $(element).text() == '1s-cancel'
      $('#cancel').prop('checked', true)


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
      console.log $(element)
      if $.isNumeric($(element).text())
        $(element).toggleClass('count')
      else if $(element).is('.roll_type')
        $(element).toggleClass('active')
      else
        $('body').find('#' + $(element).text().toLowerCase()).toggleClass('counting')
        $('body').find('#' + $(element).text().toLowerCase()).prev().toggleClass('counting')
        $('body').find('#' + $(element).text().toLowerCase()).toggleClass('count')
    count_dice()
    set_roll_type()

