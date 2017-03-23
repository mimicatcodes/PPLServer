//
//  BasicController.swift
//  helloPeople
//
//  Created by Luna An on 3/22/17.
//
//

import Foundation
import Vapor
import HTTP
import VaporPostgreSQL


final class BasicController {
    
    func addRoutes(drop: Droplet) {
        drop.get("version", handler: version)
        drop.get("model", handler: model)
        drop.get("test", handler: test)
        drop.get("new", handler: new)
        drop.get("all", handler: all)
        drop.get("delete-first", handler: deleteFirst)
    }
  
    
    func version(request: Request) throws -> ResponseRepresentable {
        if let db = drop.database?.driver as? PostgreSQLDriver {
            let version = try db.raw("SELECT version()")
            return try JSON(node: version)
        } else {
            return "No db connection"
        }
    }
    
    func model(request: Request) throws -> ResponseRepresentable {
        let person = Person(name: "Joyce", favorite_city: "Brooklyn")
        return try person.makeJSON()
    }
    
    func first(request: Request) throws -> ResponseRepresentable {
        return try JSON(node: Person.query().first()?.makeNode())
    }
    
    func test(request: Request) throws -> ResponseRepresentable {
        var person = Person(name: "Luna", favorite_city: "Paris")
        try person.save()
        return try JSON(node:Person.all().makeNode())
    }
    
    func new(request: Request) throws -> ResponseRepresentable {
        var person = try Person(node: request.json)
        try person.save()
        return person
    }
    
    func all(request: Request) throws -> ResponseRepresentable {
        return try JSON(node: Person.all().makeNode())
    }
    
//    func deleteCity(request: Request) throws -> ResponseRepresentable {
//        let query = try Person.query().filter("favoritecity", "Shanghai")
//        try query.delete()
//        return try JSON(node: Person.all().makeNode())
//
//    }
    
    func deleteFirst(request: Request) throws -> ResponseRepresentable {
        guard var firstPerson = try Person.query().first() else { throw Abort.badRequest }
        try firstPerson.delete()
        return firstPerson
    }

    func update(request: Request) throws -> ResponseRepresentable {
        guard var first = try Person.query().first(),
            let city = request.data["favoritecity"]?.string else {
                throw Abort.badRequest
        }

        first.favorite_city = city
        try first.save()
        return first
        
    }
    
    
//    
//    drop.get("hello") { req in
//    return try drop.view.make("hello")
//    //look for a leaf template named hello.leaf and present it to the user
//    }
//    
//    drop.get("helloworld") { req in
//    let greetings = ["Mundo", "Monde", "Welt"]
//    return try drop.view.make("hello", ["greeting": "World", "worlds": greetings.makeNode()])
//    }
//    
//    drop.get("wing") { req in
//    return try JSON(node:Person.query().filter("name", "Wing").all().makeNode())
//    }
//    
//    drop.get("not-wing") { req in
//    return try JSON(node: Person.query().filter("name", .notEquals, "Wing").all().makeNode())
//    }

}
