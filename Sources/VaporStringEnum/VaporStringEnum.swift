//
//  FluentStringEnum.swift
//  FluentStringEnum
//
//  Created by Christoph Pageler on 24.09.17.
//

import Vapor
import FluentProvider


enum VaporStringEnumError: Error {
    case nilValue(type: String)
    case invalidValue(value: String, type: String)
}


protocol VaporStringEnum: NodeInitializable, JSONConvertible, RowConvertible, RawRepresentable where RawValue == String {
    
    init(optionalRawValue rawValue: String?) throws
    
    init(node: Node) throws
    init(json: JSON) throws
    init(row: Row) throws
    
    func makeJSON() throws -> JSON
    func makeRow() throws -> Row
    
}


extension VaporStringEnum {
    
    init(optionalRawValue rawValue: String?) throws {
        let stringDescribingSelf = String(describing: Self.self)
        guard let rawValue = rawValue else { throw VaporStringEnumError.nilValue(type: stringDescribingSelf) }
        guard let type = Self(rawValue: rawValue) else { throw VaporStringEnumError.invalidValue(value: rawValue, type: stringDescribingSelf) }
        self.init(rawValue: type.rawValue)!
    }
    
    init(node: Node) throws {
        try self.init(optionalRawValue: node.string)
    }
    
    init(json: JSON) throws {
        try self.init(optionalRawValue: json.string)
    }
    
    init(row: Row) throws {
        try self.init(optionalRawValue: row.string)
    }
    
    func makeJSON() throws -> JSON {
        return JSON(rawValue)
    }
    
    func makeRow() throws -> Row {
        return Row(rawValue)
    }
    
}
