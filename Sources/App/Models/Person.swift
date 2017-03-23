//
//  Person.swift
//  helloPeople
//
//  Created by Luna An on 3/22/17.
//
//

import Foundation
import Vapor
import Fluent

final class Person: Model {
    var id: Node?
    var exists: Bool = false
    
    var name: String
    var favorite_city: String
    
    init(name:String, favorite_city:String) {
        self.id = nil
        self.name = name
        self.favorite_city = favorite_city
    }
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        name = try node.extract("name")
        favorite_city = try node.extract("favoritecity")
    }
    
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "id": id,
            "name": name,
            "favoritecity": favorite_city
            ])
    }
    
    static func prepare(_ database: Database) throws {
        try database.create("persons") { (users) in
            users.id()
            users.string("name")
            users.string("favoritecity")
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete("persons")
    }
}
