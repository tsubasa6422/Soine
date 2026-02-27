// app/javascript/controllers/index.js
import { Application } from "@hotwired/stimulus"
import { definitionsFromContext } from "@hotwired/stimulus-loading"

window.Stimulus = Application.start()
const context = require.context(".", true, /_controller\.js$/)
Stimulus.load(definitionsFromContext(context))