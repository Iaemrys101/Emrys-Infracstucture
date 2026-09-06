const menuButton = document.querySelector(".menu-toggle");
const nav = document.querySelector("#site-nav");
const contactForm = document.querySelector("#contact-form");
const formStatus = document.querySelector("#form-status");

menuButton.addEventListener("click", () => {
  const isOpen = nav.classList.toggle("is-open");
  menuButton.setAttribute("aria-expanded", String(isOpen));
  menuButton.setAttribute("aria-label", isOpen ? "Close navigation" : "Open navigation");
});

nav.addEventListener("click", (event) => {
  if (event.target.matches("a")) {
    nav.classList.remove("is-open");
    menuButton.setAttribute("aria-expanded", "false");
    menuButton.setAttribute("aria-label", "Open navigation");
  }
});

contactForm.addEventListener("submit", (event) => {
  event.preventDefault();

  if (!contactForm.checkValidity()) {
    formStatus.textContent = "Please complete every field with valid information.";
    contactForm.reportValidity();
    return;
  }

  const formData = new FormData(contactForm);
  const name = formData.get("name").toString().trim().split(" ")[0] || "there";

  formStatus.textContent = `Thanks, ${name}. This practice form is working.`;
  contactForm.reset();
});
