import Foundation
import Vapor
import Fluent
import VaporPostgreSQL

let drop = Droplet()
try drop.addProvider(VaporPostgreSQL.Provider.self)
drop.preparations += Person.self

(drop.view as? LeafRenderer)?.stem.cache = nil

let basic = BasicController()
basic.addRoutes(drop: drop)

let persons = PersonsController()
drop.resource("persons", persons)

// Controllers

let controller = PeopleController()
controller.addRoutes(drop: drop)

drop.run()
