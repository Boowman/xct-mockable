//
//  SourceLocation.swift
//
//
//  Created by Lenard Pop on 19/02/2024.
//

public struct SourceLocation {
    public let file: StaticString
    public let line: UInt
    
    public init(_ file: StaticString,
                _ line: UInt) {
        self.file = file
        self.line = line
    }
}
