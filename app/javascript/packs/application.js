import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "bootstrap"
import "@fortawesome/fontawesome-free/css/all.css"
import "../stylesheets/application.scss"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

const handleReplyToggle = (e) => {
  const btn = e.target.closest(".reply-toggle");
  if (!btn) return;

  e.preventDefault();
  const id = btn.dataset.commentId;
  const form = document.getElementById(`reply-form-${id}`);
  if (form) form.classList.toggle("d-none");
};

document.addEventListener("click", handleReplyToggle, false);
