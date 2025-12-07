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

