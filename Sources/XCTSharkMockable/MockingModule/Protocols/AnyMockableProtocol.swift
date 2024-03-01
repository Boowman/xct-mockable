//
//  AnyMockableProtocol.swift
//  
//
//  Created by Lenard Pop on 19/02/2024.
//

public protocol AnyMockableProtocol { 
    var context: ContextContainer { get set }
    var invocation: Invocation { get set }
}
