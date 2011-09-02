// this function updates derived character attributes when editing their form
function updateStats() {
  a = isNaN(parseInt($('#character_stamina').val())) ? 0 : parseInt($('#character_stamina').val());
  b = isNaN(parseInt($('#character_size').val())) ? 0 : parseInt($('#character_size').val());
  $('#character_health').val(a + b);
  
  a = isNaN(parseInt($('#character_resolve').val())) ? 0 : parseInt($('#character_resolve').val());
  b = isNaN(parseInt($('#character_composure').val())) ? 0 : parseInt($('#character_composure').val());
  $('#character_willpower').val(a + b);
  
  a = isNaN(parseInt($('#character_wits').val())) ? 0 : parseInt($('#character_wits').val());
  b = isNaN(parseInt($('#character_dexterity').val())) ? 0 : parseInt($('#character_dexterity').val());
  $('#character_defense').val(Math.min(a, b));
  
  a = isNaN(parseInt($('#character_dexterity').val())) ? 0 : parseInt($('#character_dexterity').val());
  b = isNaN(parseInt($('#character_composure').val())) ? 0 : parseInt($('#character_composure').val());
  $('#character_initiative').val(a + b);

  a = isNaN(parseInt($('#character_strength').val())) ? 0 : parseInt($('#character_strength').val());
  b = isNaN(parseInt($('#character_dexterity').val())) ? 0 : parseInt($('#character_dexterity').val());
  $('#character_speed').val(a + b + 5);
}

$(document).ready(function() {
  $('input.parent_number').keyup(updateStats);
});
