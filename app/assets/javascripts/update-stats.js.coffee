# this function updates derived character attributes when editing their form

$(document).ready =>
	$('input.parent_number').keyup =>
		a = parseInt($('#character_stamina').val())
		a = 0 if isNaN a
		b = parseInt($('#character_size').val())
		b = 0 if isNaN b
		$('#character_health').val(a + b)
        
		a = parseInt($('#character_resolve').val())
		a = 0 if isNaN a
		b = parseInt($('#character_composure').val())
		b = 0 if isNaN b
		$('#character_willpower').val(a + b)
  		
		a = parseInt($('#character_wits').val())
		a = 0 if isNaN a
		b = parseInt($('#character_dexterity').val())
		b = 0 if isNaN b
		$('#character_defense').val(Math.min(a, b))
		
		a = parseInt($('#character_dexterity').val())
		a = 0 if isNaN a
		b = parseInt($('#character_composure').val())
		b = 0 if isNaN b
		$('#character_initiative').val(a + b)
		
		a = parseInt($('#character_strength').val())
		a = 0 if isNaN a
		b = parseInt($('#character_dexterity').val())
		b = 0 if isNaN b
		$('#character_speed').val(a + b + 5)
