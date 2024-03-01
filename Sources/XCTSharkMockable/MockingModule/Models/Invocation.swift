//
//  Invocation.swift
//
//
//  Created by Lenard Pop on 19/02/2024.
//

public class Invocation: Hashable {
    public var key: String = ""
    public var members: [InvocationMember] = []
    
    public init(key: String,
                members: [InvocationMember]) {
        self.key = key
        self.members = members
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine([key: self.members])
    }
}

extension Invocation: Equatable {
    public static func == (lhs: Invocation, rhs: Invocation) -> Bool {
        return lhs.key == rhs.key &&
        lhs.members == rhs.members
    }
}
