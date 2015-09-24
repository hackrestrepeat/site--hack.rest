var Toggle = {
  
  initialize: function() {
    console.log('Toggle Initialized');   
    this.elements();
    this.events();
  },
  
  elements: function() {
    this.element = $('.toggle');
    this.button = $('.toggle .toggle__button');
  },

  events: function() {
    Toggle.button.on('click', Toggle.toggleState);
  },

  toggleState: function() {
    var activate = $(this).data("activate").split(" ");
    var deactivate = $(this).data("deactivate").split(" ");
    var toggle;
    var toggleButton;
    var state;

    // Toggle Activated States
    for (i=0, l=activate.length; i<l; i++) {

      toggle = $(".toggle.toggle--" + activate[i]);
      toggleButton = toggle.find('.toggle__button');
      state = activate[i];

      if ($("body.active--" + activate[i]).length) {
        deactivateAriaPressed( toggleButton );
        deactivatePageState( state );
      } else {
        activateAriaPressed( toggleButton );
        activatePageState( state );
      }
    }

      // Toggle Deactivated States
    for (i=0, l=deactivate.length; i<l; i++) {

      toggle = $(".toggle.toggle--" + deactivate[i]);
      state = deactivate[i];

      deactivateAriaPressed( toggleButton );
      deactivatePageState( state );
    }

    // Utility Functions
    function activateAriaPressed( toggle ) {
      toggle.attr("aria-pressed", "true");
    }

    function deactivateAriaPressed( toggle ) {
      toggle.attr("aria-pressed", "false");
    }

    function activatePageState( state ) {
      $("body").addClass("active--" + state);
    }

    function deactivatePageState( state ) {
      $("body").removeClass("active--" + state);
    }
  }
};

Toggle.initialize();
