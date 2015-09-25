var Logo = (function(window, undefined) {

  var component = {
    name: 'Logo'
  }
  
  function init() {
    console.log(component.name + "Initialized");
  }

  return {
    init: init
  }
  
})();
