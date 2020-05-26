//
// dropdown.js
//

'use strict';

(function() {
  var navbarDropdown = document.querySelectorAll('.navbar-nav .dropdown, .navbar-nav .dropright');

  [].forEach.call(navbarDropdown, function(dropdown) {
    "mouseenter mouseleave click".split(' ').forEach(function(event) {
      dropdown.addEventListener(event, function() {
        if (window.innerWidth > 991) {
          var toggle = dropdown.querySelector('[data-toggle="dropdown"]');

          if (event === 'mouseenter') {
            dropdown.classList.add('hovered');

            $(toggle).dropdown('show');
          } else {
            $(toggle).dropdown('hide');

            toggle.blur();
          }
        }
      });
    });
  });
})();
