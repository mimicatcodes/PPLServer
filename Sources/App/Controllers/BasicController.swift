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
    
    /*
    func all(request: Request, id: Int) throws -> ResponseRepresentable {
        guard let person = try Person.query().filter("id", id).first() else { return "No person found"}
        return try person.makeJSON()
    }*/
    
    func deleteFirst(request: Request) throws -> ResponseRepresentable {
        guard let firstPerson = try Person.query().first() else { throw Abort.badRequest }
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
}
