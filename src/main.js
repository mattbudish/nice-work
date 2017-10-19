import 'bootstrap/dist/css/bootstrap.css'

import './jquery-global.js'
import 'bootstrap'

import riot from 'riot'
import route from 'riot-route'

import './choreService.js'
import { user } from './user.model.js'
import './app.tag'
import './chore-box.tag'
import './chore-form.tag'

if (ENV !== 'production') {
  // Enable LiveReload
  document.write(
    '<script src="http://' + (location.host || 'localhost').split(':')[0] +
    ':35729/livereload.js?snipver=1"></' + 'script>'
  )
}

var api = {
  user: user
}

riot.mount('*', {
    title: "Nice Work",
    api: api
})

route.start(true)
