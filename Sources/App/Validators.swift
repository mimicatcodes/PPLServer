//
//  Validators.swift
//  helloPeople
//
//  Created by Luna An on 3/23/17.
//
//

import Foundation

//// Validators
//
//drop.get("basic") { request in
//    guard let input = request.data["input"]?.string else {
//        throw Abort.badRequest
//    }
//    return "Raw Intput: \(input)"
//
//}
//
//drop.get("alpha") { request in
//    let input: Valid<OnlyAlphanumeric> = try request.data["input"].validated()
//    return "Validated: \(input.value)"
//}
//
//drop.get("email") { request in
//    let input: Valid<Email> = try request.data["input"].validated()
//    return "Validated: \(input.value)"
//}
//
//drop.get("unique") { request in
//    guard let rawInput = request.data["input"]?.string else {
//        throw Abort.badRequest
//    }
//
//    let input: Valid<Unique<Array<String>>> = try rawInput.components(separatedBy: ",").validated()
//    return "Validated: \(input.value)"
//
//}
//
//drop.get("matches") { request in
//    guard let rawInput = request.data["input"]?.string else {
//        throw Abort.badRequest
//    }
//
//    let input: Valid<Matches<String>> = try rawInput.validated(by: Matches("The red fox trots quietly at midnight"))
//    return "Validated: \(input.value)"
//}
//
//drop.get("in") { request in
//    guard let rawInput = request.data["input"]?.string else {
//        throw Abort.badRequest
//    }
//
//    let usernames = Set(["mimi", "wing", "wingmi"])
//    let input: Valid<In<String>> = try rawInput.validated(by: In(usernames))
//    return "Validated: \(input.value)"
//}
//
//drop.get("contains") { request in
//    guard let rawInput = request.data["input"]?.string else {
//        throw Abort.badRequest
//    }
//    let input: Valid<Contains<Array<String>>> = try rawInput.components(separatedBy: ",").validated(by: Contains("wahaha"))
//
//    return "Validated: \(input.value)"
//}
//
//drop.get("count") { request in
//    guard let rawInput = request.data["input"]?.string else {
//        throw Abort.badRequest
//    }
//
//    let min: Valid<Count<Int>> = try rawInput.validated(by: Count.min(1))
//    let max: Valid<Count<Int>> = try rawInput.validated(by: Count.max(100))
//
//    let containedIn: Valid<Count<Int>> = try rawInput.validated(by: Count.containedIn(low: 40, high: 60))
//    let equals: Valid<Count<Int>> = try rawInput.validated(by: Count.equals(50))
//    return "Min: \(min.value), Max: \(max.value), Equals: \(equals.value), ContainedIn: \(containedIn.value)"
//}

//
//    func deleteCity(request: Request) throws -> ResponseRepresentable {
//        let query = try Person.query().filter("favoritecity", "Shanghai")
//        try query.delete()
//        return try JSON(node: Person.all().makeNode())
//
//    }

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


