//
//  StubbingManager.swift
//  
//
//  Created by Lenard Pop on 19/02/2024.
//

// MARK: Stubbing Calls

public func givenSwift<DeclarationType: Declaration,InvocationType, ReturnType>(
    _ mockable: Mockable<DeclarationType, InvocationType, ReturnType
    >
) -> StubbingManager<DeclarationType, InvocationType, ReturnType> {
    return given(mockable)
}

public func given<DeclarationType: Declaration,InvocationType,ReturnType>(
    _ mockable: Mockable<DeclarationType, InvocationType, ReturnType>
) -> StubbingManager<DeclarationType, InvocationType,ReturnType> {
    return StubbingManager(context: mockable.context, invocation: mockable.invocation)
}

//@available(*, deprecated, renamed: "givenSwift",
//           message: "Unable to infer types for this stub; switch to 'givenSwift' to disambiguate")
//public func given<T: AnyMockableProtocol>(_ declaration: T) -> StubbingManager<AnyDeclaration, Any?, Any?> {
//    fatalError("Incorrect parameter or return types")
//}

public func given<ReturnType>(
    _ declaration: @autoclosure () throws -> ReturnType
) -> StubbingManager<XCTMockable.VariableDeclaration, Any?, ReturnType> {
        let invocations = InvocationsRecorder().startRecording {
            _ = try? declaration()
        }
        
        guard let record = invocations.result else {
            preconditionFailure("Failed to get the records.")
        }
        
        return StubbingManager(
            context: record.context,
            invocation: record.invocation
        )
}

// MARK: Protocol Definition

public protocol StubbingManagerProtocol {
    associatedtype ReturnType
    
    func willReturn(_ value: ReturnType)
}

// MARK: Stubbing Implementation

public class StubbingManager<
    DeclarationType: Declaration,
    InvocationType,
    ReturnType
>: StubbingManagerProtocol {
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
