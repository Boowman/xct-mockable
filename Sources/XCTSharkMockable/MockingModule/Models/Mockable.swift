//
//  Mockable.swift
//  
//
//  Created by Lenard Pop on 19/02/2024.
//

public struct Mockable<DeclarationType: Declaration, ReturnType>: AnyMockableProtocol, Equatable {
    public var context: ContextContainer
    public var invocation: Invocation
    public var returnType: ObjectIdentifier
    
    public init(context: ContextContainer, 
                invocation: Invocation,
                returnType: ObjectIdentifier) {
        self.context = context
        self.invocation = invocation
        self.returnType = returnType
    }
    
    public static func == (lhs: Mockable<DeclarationType, ReturnType>, rhs: Mockable<DeclarationType, ReturnType>) -> Bool {
        return lhs.invocation == rhs.invocation &&
               lhs.returnType == rhs.returnType
    }
}
