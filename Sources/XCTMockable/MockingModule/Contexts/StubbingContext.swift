//
//  StubbingContext.swift
//
//
//  Created by Lenard Pop on 23/02/2024.
//

import Foundation

public class StubbingContext {
    private(set) var stubs: [Invocation: Any?] = [:]
    
    public init() { }
    
    public func addStubs(_ invocation: Invocation, value: Any)  {
        stubs[invocation] = value
    }
    
    public func implementation(for invocation: Invocation) -> Any? {
        guard let stub = stubs[invocation] else { return nil }
        
        return stub
    }
}
