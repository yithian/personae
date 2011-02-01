// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
(function() {
  function handleRemote(element) {
    var method, url, params;

    var event = element.fire("ajax:before");
    if (event.stopped) return false;

    if (element.tagName.toLowerCase() === 'select' || element.tagName.toLowerCase() === 'input') {
      method = element.readAttribute('method') || 'post';
      url    = element.readAttribute('action');
      params = element.serialize();
    }

    new Ajax.Request(url, {
      method: method,
      parameters: params,
      evalScripts: true,

      onComplete:    function(request) { element.fire("ajax:complete", request); },
      onSuccess:     function(request) { element.fire("ajax:success",  request); },
      onFailure:     function(request) { element.fire("ajax:failure",  request); }
    });

    element.fire("ajax:after");
  }

  // This block fires an ajax action when marked dropdown menus have their value changed
  document.on("change", $('select[remote=true]'), function(event, element) {
    if (event.stopped) return;
    handleRemote(element);
    event.stop();
  });

  // This block fires an ajax action when marked input fields have their contents updated
  document.on("keyup", $('input[remote=true]'), function(event, element) {
    if (event.stopped) return;
    handleRemote(element);
    event.stop();
  });

  // this segment handles automatic resizing of text areas
  if (window.Widget == undefined) window.Widget = {}; 
  
  Widget.Textarea = Class.create({
    initialize: function(textarea, options) {
      this.textarea = $(textarea);
      this.options = $H({ }).update(options);
  
      // Disable scroll bars and Safari resizing.
      this.textarea.setStyle({ overflowY: 'hidden', resize: 'none' });
  
      // See notes above.
      this.original_height = parseInt(this.textarea.getStyle('height'));
  
      // Used to store the scroll offset of the shadow textarea so that we only 
      // need to do a resize if there's a change to this value.
      this.previous_scroll_top = 0;
  
      // Clone the textarea and copy any styles that will affect the amount of 
      // space consumed by text.
      this._shadow = this.textarea.cloneNode(false).setStyle({
        lineHeight: this.textarea.getStyle('lineHeight'),
        fontSize: this.textarea.getStyle('fontSize'),
        fontFamily: this.textarea.getStyle('fontFamily'),
        letterSpacing: this.textarea.getStyle('letterSpacing'),
        width: this.textarea.getStyle('width'),
        height: this.textarea.getStyle('height'),
        position: 'absolute',
        top: '-10000px',
        left: '-10000px'
      }).writeAttribute({ id: null, name: null, disabled: true });
  
      this.textarea.insert({ after: this._shadow });
  
      // Could also fire on keydown, but I don't have a strong enough reason to 
      // do so at present. We'd be doubling the number of calls to refresh().
      this.textarea.observe('keyup', this.refresh.bind(this));
      this.textarea.observe('change', this.refresh.bind(this));
      this.refresh();
    },
  
    refresh: function() { 
      // Update the shadow textarea and scroll to the bottom.
      this._shadow.update($F(this.textarea).replace(/</g, '&lt;').replace(/&/g, '&amp;')).scrollTop = 10000;
  
      // Do nothing if the scroll offset hasn't changed.
      if(this._shadow.scrollTop == this.previous_scroll_top) { return; }
  
      this.textarea.setStyle({
        height: (this._shadow.scrollTop + this.original_height) + 'px'
      });
  
      this.previous_scroll_top = this._shadow.scrollTop;
    }
  });
  
  Event.observe(window, 'load', function() {
    $$('textarea').each(function(textarea) {
      va = new Widget.Textarea(textarea);
    });
  });

  // this function updates derived character attributes when editing their form
  function updateStats() {
    a = isNaN(parseInt($('character_stamina').value)) ? 0 : parseInt($('character_stamina').value);
    b = isNaN(parseInt($('character_size').value)) ? 0 : parseInt($('character_size').value);
    $('character_health').value = a + b;
    
    a = isNaN(parseInt($('character_resolve').value)) ? 0 : parseInt($('character_resolve').value);
    b = isNaN(parseInt($('character_composure').value)) ? 0 : parseInt($('character_composure').value);
    $('character_willpower').value = a + b;
    
    a = isNaN(parseInt($('character_wits').value)) ? 0 : parseInt($('character_wits').value);
    b = isNaN(parseInt($('character_dexterity').value)) ? 0 : parseInt($('character_dexterity').value);
    $('character_defense').value = Math.min(a, b);
    
    a = isNaN(parseInt($('character_dexterity').value)) ? 0 : parseInt($('character_dexterity').value);
    b = isNaN(parseInt($('character_composure').value)) ? 0 : parseInt($('character_composure').value);
    $('character_initiative').value = a + b;

    a = isNaN(parseInt($('character_strength').value)) ? 0 : parseInt($('character_strength').value);
    b = isNaN(parseInt($('character_dexterity').value)) ? 0 : parseInt($('character_dexterity').value);
    $('character_speed').value = a + b + 5;
  }

  // fires the javascript to update derived stats on keyup in certain input classes
  document.observe("dom:loaded", function() {
    $$('input.parent_number').each(function(e) {
      e.observe('keyup', updateStats);
    });
  });
}) ();
