define(function() {
  "use strict";

  function fadeOutElement(element) {
    var fadeEffect = setInterval(function() {
      if (element.style.opacity > 0) {
        element.style.opacity -= 0.1;
      } else {
        element.textContent = "";
        element.parentElement.style.height = "24px";
        element.parentElement.style.paddingBottom = "25px";
        clearInterval(fadeEffect);
      }
    }, 100);
  }

  function flashFeedback($colourTile, colour) {
    var feedbackMessage = document.createElement("div");
    feedbackMessage.style.marginTop = "-8px";
    feedbackMessage.style.color = colour;
    feedbackMessage.style.filter = "invert(100%)";
    feedbackMessage.style.opacity = "1";
    feedbackMessage.textContent = "Copied!";

    $colourTile.style.paddingBottom = "9px";
    $colourTile.appendChild(feedbackMessage);
    fadeOutElement(feedbackMessage);
  }

  function copyToClipboard($colourTile) {
    var colour = $colourTile.textContent,
        target = document.createElement("textarea");
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
    flashFeedback($colourTile, colour);
  }

  function ClickToCopy($colourTile) {
    $colourTile.addEventListener("click", function() {
      copyToClipboard($colourTile);
    });
  }

  return ClickToCopy;
});
