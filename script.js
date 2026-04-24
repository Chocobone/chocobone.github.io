document.addEventListener("DOMContentLoaded", () => {
  const header = document.querySelector("header");
  const scrollBtn = document.getElementById("scroll-to-top");

  window.addEventListener("scroll", () => {
    const scrollPos = window.scrollY || document.documentElement.scrollTop;

    // Sticky Header
    if (scrollPos > 50) {
      header.classList.add("sticky");
    } else {
      header.classList.remove("sticky");
    }

    // Scroll to Top Button
    if (scrollPos > 300) {
      scrollBtn.classList.add("active");
    } else {
      scrollBtn.classList.remove("active");
    }
  });

  scrollBtn.addEventListener("click", () => {
    window.scrollTo({
      top: 0,
      behavior: "smooth",
    });
  });
});
