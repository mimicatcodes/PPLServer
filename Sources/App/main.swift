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

/*
drop.get("people", Int.self) { request, id in
    guard let person = try Person.query().filter("id", id).first() else {
        return "No person found"
    }
    return try person.makeJSON()
}*/

let persons = PersonsController()
drop.resource("people", persons)

let controller = AllController()
controller.addRoutes(drop: drop)

drop.run()
