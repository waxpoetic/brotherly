// Load all the controllers within this directory and all subdirectories.
// Controller files must be named *_controller.js.

import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"
import Rails from "rails-ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "activestorage"

const application = Application.start()
const context = require.context("controllers", true, /_controller\.js$/)

Rails.start()
ActiveStorage.start()
Turbolinks.start()

application.load(definitionsFromContext(context))
