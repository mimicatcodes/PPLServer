//
//  PersonsController.swift
//  helloPeople
//
//  Created by Luna An on 3/22/17.
//
//

import Foundation
import Vapor
import HTTP
import VaporPostgreSQL

final class PersonsController : ResourceRepresentable {
    
    func index(request: Request) throws -> ResponseRepresentable {
        return try JSON(node: Person.all().makeNode())
    }
    
    func create(request: Request) throws -> ResponseRepresentable {
        var person = try request.person()
        try person.save()
        return person
    }
    
    func show(request: Request, person: Person) throws -> ResponseRepresentable {
        return person
    }
    
    func replace(request: Request, person: Person) throws -> ResponseRepresentable {
        try person.delete()
        return try create(request: request)
    }
    
    func clear(request: Request) throws -> ResponseRepresentable {
        try Post.query().delete()
        return JSON([])
    }
    
    func update(request: Request, person: Person) throws -> ResponseRepresentable {
        let new = try request.person()
        var person = person
        person.name = new.name
        person.favorite_city = new.favorite_city
        try person.save()
        return person
    }
    
    func delete(request: Request, person: Person) throws -> ResponseRepresentable {
        try person.delete()
        return JSON([:])
    }
    
    func makeResource() -> Resource<Person> {
        return Resource(
            index: index,
            store: create,
            show: show,
            replace: update,
            modify: update,
            destroy: delete,
            clear: clear
        )
    }
}

extension Request {
    func person() throws -> Person {
        guard let json = json else { throw Abort.badRequest }
        return try Person(node: json)
    }
}


