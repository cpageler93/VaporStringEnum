//
//  FluentStringEnum.swift
//  FluentStringEnum
//
//  Created by Christoph Pageler on 24.09.17.
//

import Vapor
import FluentProvider


public enum VaporStringEnumError: Error {
    case nilValue(type: String)
    case invalidValue(value: String, type: String)
}


public protocol VaporStringEnum: NodeInitializable, JSONConvertible, RowConvertible, RawRepresentable where RawValue == String {
    
    init(optionalRawValue rawValue: String?) throws
    
    init(node: Node) throws
    init(json: JSON) throws
    init(row: Row) throws
    
    func makeJSON() throws -> JSON
    func makeRow() throws -> Row
    
}


public extension VaporStringEnum {
    
    public init(optionalRawValue rawValue: String?) throws {
        let stringDescribingSelf = String(describing: Self.self)
        guard let rawValue = rawValue else { throw VaporStringEnumError.nilValue(type: stringDescribingSelf) }
        guard let type = Self(rawValue: rawValue) else { throw VaporStringEnumError.invalidValue(value: rawValue, type: stringDescribingSelf) }
        self.init(rawValue: type.rawValue)!
    }
    
    public init(node: Node) throws {
        try self.init(optionalRawValue: node.string)
    }
    
    public init(json: JSON) throws {
        try self.init(optionalRawValue: json.string)
    }
    
    public init(row: Row) throws {
        try self.init(optionalRawValue: row.string)
    }
    
    public func makeJSON() throws -> JSON {
        return JSON(rawValue)
    }
    
    public func makeRow() throws -> Row {
        return Row(rawValue)
    }
    
}
