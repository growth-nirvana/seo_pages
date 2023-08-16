function toggleMobileMenu() {
  document.getElementById("mobile-menu").classList.toggle("hidden");
}

// Filter of Connectors#index
document.addEventListener("DOMContentLoaded", function () {
  const filterInput = document.getElementById("connector-filter-name");
  const cards = document.querySelectorAll(".connector-card");
  const noResultsMessage = document.querySelector(".no-results");

  let delayTimer;

  filterInput.addEventListener("input", function () {
    clearTimeout(delayTimer);

    delayTimer = setTimeout(function () {
      const filterValue = filterInput.value.toLowerCase();
      let anyVisible = false;

      cards.forEach(function (card) {
        const cardTitle = card.querySelector(".card-title").textContent.toLowerCase();

        if (cardTitle.includes(filterValue)) {
          card.style.display = "block";
          anyVisible = true;
        } else {
          card.style.display = "none";
        }
      });

      if (anyVisible) {
        noResultsMessage.classList.add("hidden");
      } else {
        noResultsMessage.classList.remove("hidden");
      }
    }, 300);
  });
});
