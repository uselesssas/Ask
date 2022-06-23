# README

`rails new ASK -T --css bootstrap -j webpack`

package.json

`"@rails/ujs": "^6.0.0",`

`"turbolinks": "^5.2.0"`

application.js

`import Rails from "@rails/ujs"`

`import Turbolinks from "turbolinks"`

`Rails.start()`

`Turbolinks.start()`

* Ruby version: 3.1.2
* Rails version: ~> 7
* Added gems: pagy ~> 5, faker ~> 2, bcrypt ~> 3, draper ~> 4, valid_email2 ~> 4
* CSS: bootstrap
* JS: webpack
* Database: sqlite3 (In the future there will be PostgreSQL)