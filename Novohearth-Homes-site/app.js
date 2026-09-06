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

const filters = document.querySelector('#property-filters');
const maxPrice = document.querySelector('#max-price');
const minBeds = document.querySelector('#min-beds');
const cards = [...document.querySelectorAll('.listing-card')];
const results = document.querySelector('#listing-results');
const empty = document.querySelector('#listing-empty');
function updateListings() {
  const budget = maxPrice.value === '' ? Infinity : Number(maxPrice.value);
  const bedrooms = Number(minBeds.value);
  let count = 0;
  cards.forEach(card => {
    card.hidden = Number(card.dataset.price) > budget || Number(card.dataset.beds) < bedrooms;
    if (!card.hidden) count++;
  });
  results.textContent = count === cards.length ? 'Showing all ' + count + ' homes' : 'Showing ' + count + ' of ' + cards.length + ' homes';
  empty.hidden = count !== 0;
}
filters.hidden = false;
filters.addEventListener('change', updateListings);
filters.addEventListener('submit', event => event.preventDefault());
filters.addEventListener('reset', () => { setTimeout(updateListings, 0); });
document.querySelector('#empty-reset').addEventListener('click', () => { filters.reset(); maxPrice.focus(); });
updateListings();
