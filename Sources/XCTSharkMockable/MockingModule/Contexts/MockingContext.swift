//
//  MockingContext.swift
//
//
//  Created by Lenard Pop on 19/02/2024.
//

public class MockingContext: MockingContextProtocol {
    private(set) var allInvocations: [Invocation] = [Invocation]()
    
    public init() { }
    
    public func didInvoke<ReturnType>(_ invocation: Invocation, 
                                      completion: @escaping (Invocation) -> ReturnType) -> ReturnType {
        self.invoke(invocation)
        return completion(invocation)
    }
    
    public func invoke(_ invocation: Invocation)  {
        if self.allInvocations.filter({ $0 == invocation }).isEmpty == true {
            self.allInvocations.append(invocation)
        }
    }
}
