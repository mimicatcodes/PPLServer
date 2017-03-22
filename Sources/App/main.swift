import Foundation
import Vapor
import Fluent
import VaporPostgreSQL

let drop = Droplet()
try drop.addProvider(VaporPostgreSQL.Provider.self)
drop.preparations += Person.self

drop.get { req in
    return try drop.view.make("welcome", [
    	"message": drop.localization[req.lang, "welcome", "title"]
    ])
}

drop.get("hello") { req in
    return try drop.view.make("hello")
    //look for a leaf template named hello.leaf and present it to the user
}

drop.get("helloworld") { req in
    let greetings = ["Mundo", "Monde", "Welt"]
    return try drop.view.make("hello", ["greeting": "World", "worlds": greetings.makeNode()])
}

drop.get("all") { req in
    return try JSON(node:Person.all().makeNode())
}

drop.get("first") { req in
    return try JSON(node: Person.query().first()?.makeNode())
}

drop.get("wing") { req in
    return try JSON(node:Person.query().filter("name", "Wing").all().makeNode())
}

drop.get("not-wing") { req in
    return try JSON(node: Person.query().filter("name", .notEquals, "Wing").all().makeNode())
}

drop.get("update") { req in
    guard var first = try Person.query().first(),
        let city = req.data["favoritecity"]?.string else {
            throw Abort.badRequest
    }
    
    first.favorite_city = city
    try first.save()
    return first
}

drop.get("delete-city") { req in
    let query = try Person.query().filter("favoritecity", "Shanghai")
    try query.delete()
    return try JSON(node: Person.all().makeNode())
}

drop.get { req in
    var person = Person(name: "Wing", favorite_city: "Hong Kong")
    try person.save()
    return try person.makeJSON()
}

drop.get { req in
    return try drop.view.make("new")
}

drop.post("submit") { req in
    
    guard let name = req.formURLEncoded?["name"]?.string, let city = req.formURLEncoded?["favoritecity"]?.string else {
        return "Missing Fields"
    }
    
    var person = Person(name:name , favorite_city: city)
    try person.save()
    
    return try person.makeJSON()
}

// Querying the database

drop.get("persons") { req in
    
    let persons = try Person.query().all()
    return try persons.makeJSON()
    
}

drop.get("persons", Int.self) { req, id in
    
    guard let blog = try Person.query().filter("id", id).first() else { return "No person found" }
    
    return try blog.makeJSON()
    
}


drop.resource("posts", PostController())

drop.run()
