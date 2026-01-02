import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";

import "bootstrap";
import "@fortawesome/fontawesome-free/css/all.css";
import "../stylesheets/application.scss";

Rails.start();
Turbolinks.start();
ActiveStorage.start();


const handleReplyToggle = (e) => {
  const btn = e.target.closest(".reply-toggle");
  if (!btn) return;

  e.preventDefault();
  const id = btn.dataset.commentId;
  const form = document.getElementById(`reply-form-${id}`);
  if (form) form.classList.toggle("d-none");
};
document.addEventListener("click", handleReplyToggle, false);


const handleImageZoom = (e) => {
  const trigger = e.target.closest(".js-zoom-image");
  if (!trigger) return;

  e.preventDefault();

  const modalImg = document.getElementById("modalImage");
  if (!modalImg) return;

  const url = trigger.dataset.imageUrl;
  if (url) modalImg.src = url;
};
document.addEventListener("click", handleImageZoom, false);


document.addEventListener("turbolinks:load", () => {
  const modalImg = document.getElementById("modalImage");
  const modalEl = document.getElementById("imageModal");
  if (!modalImg || !modalEl) return;

  if (modalEl.dataset.bound === "1") return;
  modalEl.dataset.bound = "1";

  modalEl.addEventListener("hidden.bs.modal", () => {
    modalImg.src = "";
  });
});
