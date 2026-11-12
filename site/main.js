const DESCRIPTIONS = {
  morning: "Bright paper with deep, AA-contrast inks.",
  afternoon: "Slate blue, a softer mid-tone.",
  evening: "Cool navy with warm café accents. The default.",
  midnight: "Near-black ink for low-light sessions.",
  graveyard: "Black, for OLED screens and dark rooms.",
};

const shot = document.getElementById("shot");

function apply(style, save) {
  if (!(style in DESCRIPTIONS)) return;
  document.documentElement.dataset.style = style;
  for (const el of document.querySelectorAll("[data-pick]")) {
    el.setAttribute("aria-pressed", String(el.dataset.pick === style));
  }
  shot.src = `assets/screenshots/${style}.png`;
  shot.alt = `kissaten-${style} in LazyVim`;
  document.getElementById("shot-name").textContent = `kissaten-${style}`;
  document.getElementById("shot-desc").textContent = DESCRIPTIONS[style];
  if (save) {
    try {
      localStorage.setItem("kissaten-style", style);
    } catch {
      // storage blocked (private mode, file://): the pick just won't persist
    }
  }
}

function selectTab(name) {
  for (const tab of document.querySelectorAll("[data-tab]")) {
    tab.setAttribute("aria-selected", String(tab.dataset.tab === name));
  }
  for (const panel of document.querySelectorAll("[data-panel]")) {
    panel.hidden = panel.dataset.panel !== name;
  }
}

document.addEventListener("click", async (e) => {
  const pick = e.target.closest("[data-pick]");
  if (pick) return apply(pick.dataset.pick, true);

  const tab = e.target.closest("[data-tab]");
  if (tab) return selectTab(tab.dataset.tab);

  const copy = e.target.closest("[data-copy]");
  if (copy) {
    try {
      await navigator.clipboard.writeText(copy.parentElement.querySelector("code").textContent);
      copy.textContent = "copied";
    } catch {
      copy.textContent = "copy failed";
    }
    setTimeout(() => (copy.textContent = "copy"), 1500);
  }
});

apply(document.documentElement.dataset.style, false);
selectTab("lazyvim");
