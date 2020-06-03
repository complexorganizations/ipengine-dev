//
// navbar.js
// Theme module
//

'use strict';

(function() {

  //
  // Variables
  //

  var navbar = document.querySelector('.navbar');
  var isLight = false;
  var isTogglable = navbar ? navbar.classList.contains('navbar-togglable') : false;

  //
  // Functions
  //

  function makeNavbarLight() {
    if (!isLight && isTogglable) {
      navbar.classList.remove('navbar-dark');
      navbar.classList.add('navbar-light');
      navbar.classList.add('bg-white');
      navbar.classList.add('border-bottom');

      isLight = true;
    }
  }

  function makeNavbarDark() {
    if (isLight && isTogglable) {
      navbar.classList.remove('navbar-light');
      navbar.classList.remove('bg-white');
      navbar.classList.remove('border-bottom');
      navbar.classList.add('navbar-dark');

      repaintNav();

      isLight = false;
    }
  }

  // Repaint hack for Safari overscroll bug
  function repaintNav() {
    navbar.style.display = 'none';
    navbar.offsetHeight;
    navbar.style.display = 'block';
  }

  function toggleNavbar(event) {
    var scrollTop = window.pageYOffset;

    if (scrollTop > 0 && !isLight) {
      makeNavbarLight();
    } else if (scrollTop == 0 || scrollTop < 0 && isLight) {
      makeNavbarDark();
    }
  }

  //
  // Events
  //

  if (navbar && isTogglable) {
    "load scroll".split(' ').forEach(function(e) {
      window.addEventListener(e, function(e) {
        var type = e.type;

        toggleNavbar(type);
      });
    });
  }

})();
