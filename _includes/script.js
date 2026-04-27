document.addEventListener("DOMContentLoaded", () => {
  const balloon = document.createElement("div");
  balloon.className = "nes-balloon from-right copied-balloon";
  balloon.innerHTML = "<p>Copied!</p>";
  document.body.appendChild(balloon);

  function showCopiedBalloon(top, left) {
    balloon.style.display = "block";
    balloon.style.top = `${top - 60}px`;
    balloon.style.left = `${left - 100}px`;
    setTimeout(() => {
      balloon.style.display = "none";
    }, 1000);
  }

  // Only target the outermost .highlight element to avoid duplicates
  document.querySelectorAll(".highlight").forEach((block) => {
    // If this .highlight is inside another .highlight, skip it
    if (block.parentElement.closest(".highlight")) return;
    if (block.querySelector(".copy-code-button")) return;

    const lights = document.createElement("div");
    lights.className = "code-traffic-lights";
    lights.innerHTML =
      '<span class="traffic-light tl-red"></span>' +
      '<span class="traffic-light tl-yellow"></span>' +
      '<span class="traffic-light tl-green"></span>';
    block.insertBefore(lights, block.firstChild);

    const button = document.createElement("button");
    button.className = "nes-btn is-primary copy-code-button";
    button.type = "button";
    button.innerText = "Copy";

    button.addEventListener("click", (e) => {
      const code = block.querySelector("code").innerText;
      const textarea = document.createElement("textarea");
      textarea.value = code;
      document.body.appendChild(textarea);
      textarea.select();
      document.execCommand("copy");
      document.body.removeChild(textarea);

      showCopiedBalloon(e.pageY, e.pageX);
    });

    block.style.position = "relative";
    block.appendChild(button);
  });
});
