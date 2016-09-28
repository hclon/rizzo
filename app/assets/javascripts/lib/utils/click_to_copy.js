define(function() {
  "use strict";

  function copyToClipboard(colour) {
    var target = document.createElement("textarea");
    target.style.position = "absolute";
    target.style.left = "-9999px";
    target.style.top = "0";

    var currentX = window.scrollX,
        currentY = window.scrollY;
    document.body.appendChild(target);

    target.textContent = colour;
    target.focus();
    target.setSelectionRange(0, 7);
    document.execCommand("copy");

    window.scrollTo(currentX, currentY);
    target.textContent = "";
    target.outerHTML = "";
  }

  function ClickToCopy($target) {
    $target.addEventListener("click", function() {
      copyToClipboard($target.textContent);
    });
  }

  return ClickToCopy;
});
