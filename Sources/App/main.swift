import Foundation
import Vapor
import Fluent
import VaporPostgreSQL

let drop = Droplet()

try drop.addProvider(VaporPostgreSQL.Provider.self)
drop.preparations += Person.self

drop.get { req in
    return try drop.view.make("welcome")
}

(drop.view as? LeafRenderer)?.stem.cache = nil

let basic = BasicController()
basic.addRoutes(drop: drop)

let persons = PersonsController()
drop.resource("people", persons)

let controller = AllController()
controller.addRoutes(drop: drop)

drop.run()
