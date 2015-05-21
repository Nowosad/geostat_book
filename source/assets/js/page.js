domready(function () {
  // Shorten "document.getElementById" variable
  var id = function(e) {return document.getElementById(e);};
  // Shorten local storage variables
  // if encounter trouble, switch to https://github.com/nbubna/store
  var removeStor = function(key) {return localStorage.removeItem(key);};
  var setStor = function(key, value) {return localStorage.setItem(key, value);};
  var getStor = function(key) {return localStorage.getItem(key);};

  // toggle main menu and use localstorage for persistence
  id("toggle-summary").onclick = function() {
    if(id("book").hasClass("with-summary")) {
      id("book").removeClass("with-summary");
      removeStor("with-summary");
    } else{
      id("book").addClass("with-summary");
      setStor("with-summary", "0");
    }
    // remove font-settings menu when clicked
    if(id("font-settings-dropdown").hasClass("open")) {
      id("font-settings-dropdown").removeClass("open");
    }
  }
    if (getStor("with-summary") != null) {
      id("book").addClass("with-summary");
    }

  // toggle font-settings menu and remove when clicked elsewhere
  id("toggle-font-settings").onclick = function() {
      id("font-settings-dropdown").toggleClass("open");
    }
    // must separate as just using body immediately reverts
    id("book-summary").onclick = function() {
      id("font-settings-dropdown").removeClass("open");
    }
    id("book-body").onclick = function() {
      id("font-settings-dropdown").removeClass("open");
    }

  // toggle font-settings normal size and use localstorage for persistence
  id("reduce-font-size").onclick = function() {
    id("book").removeClass("font-size-2");
    id("book").addClass("font-size-1");
    removeStor("font-size-2");
    setStor("font-size-1", "0");
  }
    if (getStor("font-size-1") != null) {
      id("book").addClass("font-size-1");
    }

  // toggle font-settings larger size and use localstorage for persistence
  id("enlarge-font-size").onclick = function() {
    id("book").removeClass("font-size-1");
    id("book").addClass("font-size-2");
    removeStor("font-size-1");
    setStor("font-size-2", "0");
  }
    if (getStor("font-size-2") != null) {
      id("book").addClass("font-size-2");
      id("book").removeClass("font-size-1");
    }

  // toggle font-settings serif and use localstorage for persistence
  id("serif").onclick = function() {
    id("book").removeClass("font-family-1");
    id("book").addClass("font-family-0");
    removeStor("font-family-1");
    setStor("font-family-0", "0");
  }
    if (getStor("font-family-0") != null) {
      id("book").addClass("font-family-0");
      id("book").removeClass("font-family-1");
    }

  // toggle font-settings sans and use localstorage for persistence
  id("sans").onclick = function() {
    id("book").removeClass("font-family-0");
    id("book").addClass("font-family-1");
    removeStor("font-family-0");
    setStor("font-family-1", "0");
  }
    if (getStor("font-family-1") != null) {
      id("book").addClass("font-family-1");
    }

  // toggle font-settings white background
  id("color-theme-preview-0").onclick = function() {
    id("book").removeClass("color-theme-1");
    id("book").removeClass("color-theme-2");
    removeStor('color-theme-1');
    removeStor('color-theme-2');
  }

  // toggle font-settings sepia background and use localstorage for persistence
  id("color-theme-preview-1").onclick = function() {
    id("book").addClass("color-theme-1");
    id("book").removeClass("color-theme-2");
    setStor('color-theme-1','0');
    removeStor('color-theme-2');
  }
    if (getStor("color-theme-1") != null) {
      id("book").addClass("color-theme-1");
      id("book").removeClass("color-theme-2");
    }

  // toggle font-settings dark background and use localstorage for persistence
  id("color-theme-preview-2").onclick = function() {
    id("book").addClass("color-theme-2");
    id("book").removeClass("color-theme-1");
    setStor('color-theme-2','0');
    removeStor('color-theme-1');
  }
    if (getStor("color-theme-2") != null) {
      id("book").addClass("color-theme-2");
      id("book").removeClass("color-theme-1");
    }

  // add active attribute to highlight summary links
  var url = window.location.pathname;
  document.querySelector('ul.summary li a[href$="'+url+'"]').parentNode.addClass('active');
});
