/*CSSClass https://github.com/EarMaster/CSSClass (c) Nico Wiedemann*/
(function(){Array.prototype.CSSClassIndexOf=Array.prototype.indexOf||function(a){for(var b=this.length,e=0;e<b;e++)if(this[e]===a)return e;return-1};var d="classList"in document.createElement("a"),c=Element.prototype;d?(c.hasClass||(c.hasClass=function(a){var b=!0;Array.prototype.slice.call(this.classList);a=a.split(" ");for(var e=0;e<a.length;e++)this.classList.contains(a[e])||(b=!1);return b}),c.addClass||(c.addClass=function(a){a=a.split(" ");for(var b=0;b<a.length;b++)this.hasClass(a[b])||this.classList.add(a[b]); return this}),c.removeClass||(c.removeClass=function(a){this.className.split(" ");a=a.split(" ");for(var b=0;b<a.length;b++)this.hasClass(a[b])&&this.classList.remove(a[b]);return this}),c.toggleClass||(c.toggleClass=function(a){a=a.split(" ");for(var b=0;b<a.length;b++)this.classList.toggle(a[b]);return this})):(c.hasClass||(c.hasClass=function(a){var b=!0,e=this.className.split(" ");a=a.split(" ");for(var c=0;c<a.length;c++)-1===e.CSSClassIndexOf(a[c])&&(b=!1);return b}),c.addClass||(c.addClass= function(a){a=a.split(" ");for(var b=0;b<a.length;b++)this.hasClass(a[b])||(this.className=""!==this.className?this.className+" "+a[b]:a[b]);return this}),c.removeClass||(c.removeClass=function(a){var b=this.className.split(" ");a=a.split(" ");for(var c=0;c<a.length;c++)this.hasClass(a[c])&&b.splice(b.CSSClassIndexOf(a[c]),1);this.className=b.join(" ");return this}),c.toggleClass||(c.toggleClass=function(a){a=a.split(" ");for(var b=0;b<a.length;b++)this.hasClass(a[b])?this.removeClass(a[b]):this.addClass(a[b]); return this}));d=NodeList.prototype;d.hasClass||(d.hasClass=function(a,b){void 0===b&&(b=!0);for(var c=0,d=b?!0:!1;(b&&!0===d||!b&&!1===d)&&c<this.length;++c)d=this[c].hasClass(a);return d});d.addClass||(d.addClass=function(a){for(var b=0;b<this.length;++b)this[b].addClass(a)});d.removeClass||(d.removeClass=function(a){for(var b=0;b<this.length;++b)this[b].removeClass(a)});d.toggleClass||(d.toggleClass=function(a){for(var b=0;b<this.length;++b)this[b].toggleClass(a)})})();
/*END CssClass*/

// Shorten "document.getElementById" variable
var id = function(e) {return document.getElementById(e);};
// Shorten local storage variables. If encounter trouble, switch to https://github.com/nbubna/store
var removeStor = function(key) {return localStorage.removeItem(key);};
var setStor = function(key, value) {return localStorage.setItem(key, value);};
var getStor = function(key) {return localStorage.getItem(key);};

document.addEventListener("DOMContentLoaded", function(event) {
  var width = window.innerWidth

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
    // Remove summary if click on body for small screens
    width = window.innerWidth
    if (width < 675) {
      id("book").removeClass("with-summary");
      removeStor("with-summary");
    }
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
  
  // Add active class to highlight current page on toc
  // This is code for when the page loads
  var url = document.location.href; // Stores url
  url = url.substring(url.lastIndexOf("/") + 1, url.length); // Removes everything before the last slash in the path
  document.querySelector('ul.summary a[href$="'+url+'"]').parentNode.addClass('active'); // Adds active class to highlight toc
  // This is code for when a hash is added to the url
  window.onhashchange = function () {
  	// Remove summary if hash change for mobile devices
  	width = window.innerWidth
  	if (width < 675) {
      id("book").removeClass("with-summary");
      removeStor("with-summary");
    }
    document.querySelector('ul.summary a[href$="'+url+'"]').parentNode.removeClass('active'); // Remove the active class from old url
    var hashurl = document.location.href; // Store new hash url
    hashurl = hashurl.substring(hashurl.lastIndexOf("/") + 1, hashurl.length);
    document.querySelector('ul.summary a[href$="'+hashurl+'"]').parentNode.addClass('active');
    url = document.location.href; // Stores new url so it can be removed later
    url = url.substring(url.lastIndexOf("/") + 1, url.length);
  }
});
