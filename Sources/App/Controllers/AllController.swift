//
//  AllController.swift
//  helloPeople
//
//  Created by Luna An on 3/22/17.
//
//

import Foundation
import Vapor
import HTTP

final class AllController {
    func addRoutes(drop:Droplet) {
        drop.get("all", handler: indexView)
        drop.post("all", handler: addPerson)
        drop.post("all", Person.self, "delete", handler: deletePerson)
    }
    
    func indexView(request: Request) throws -> ResponseRepresentable {
        let persons = try Person.all().makeNode()
        let params = try Node(node:[
                "persons": persons
            ])
        return try drop.view.make("index", params)
    }
    
    func addPerson(request: Request) throws -> ResponseRepresentable {
        guard let name = request.data["name"]?.string, let city = request.data["favoritecity"]?.string else {
            throw Abort.badRequest
        }
        var person = Person(name: name, favorite_city: city)
        try person.save()
        
        return Response(redirect: "/all")
    }
    
    func deletePerson(request: Request, person: Person) throws -> ResponseRepresentable {
        try person.delete()
        return Response(redirect: "/all")
    }
}
