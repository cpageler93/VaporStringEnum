//
//  FluentStringEnumMiddleware.swift
//  FluentStringEnum
//
//  Created by Christoph Pageler on 24.09.17.
//

import HTTP
import Vapor
import Foundation

public final class VaporStringEnumMiddleware: Middleware {

    public init() { }

    public func respond(to request: Request, chainingTo next: Responder) throws -> Response {
        do {
            return try next.respond(to: request)
        } catch VaporStringEnumError.nilValue(let type) {
            throw Abort(.badRequest, reason: "Nil value for enum of type `\(type)`")
        } catch VaporStringEnumError.invalidValue(let value, let type) {
            throw Abort(.badRequest, reason: "Invalid value `\(value)` for enum of type `\(type)`")
        }
    }
    
}
