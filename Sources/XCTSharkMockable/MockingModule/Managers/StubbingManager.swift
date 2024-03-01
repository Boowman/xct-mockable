//
//  StubbingManager.swift
//  
//
//  Created by Lenard Pop on 19/02/2024.
//

// MARK: Stubbing Calls

public func given<DeclarationType: Declaration, ReturnType>(_ mockable: Mockable<DeclarationType, ReturnType>) -> StubbingManager<DeclarationType, ReturnType> {
    return StubbingManager(context: mockable.context,
                           invocation: mockable.invocation)
}

public func given<ReturnType>(_ declaration: @autoclosure () throws -> ReturnType) -> StubbingManager<XCTSharkMockable.VariableDeclaration, ReturnType> {
    let invocations = InvocationsRecorder().startRecording {
        _ = try? declaration()
    }
    
    guard let record = invocations.result else {
        preconditionFailure("Failed to get the records.")
    }
    
    return StubbingManager(context: record.context,
                           invocation: record.invocation)
}

// MARK: Protocol Definition

public protocol StubbingManagerProtocol {
    associatedtype ReturnType
    
    func willReturn(_ value: ReturnType)
}

// MARK: Stubbing Implementation

public class StubbingManager<DeclarationType: Declaration, ReturnType>: StubbingManagerProtocol {
    private let context: ContextContainer
    private let invocation: Invocation
        
    public init(context: ContextContainer, invocation: Invocation) {
        self.context = context
        self.invocation = invocation
    }
    
    public func willReturn(_ value: ReturnType) {
        self.context.stubbing.addStubs(invocation, value: value)
    }
}
