//
//  VerificationManager.swift
//  
//
//  Created by Lenard Pop on 19/02/2024.
//

import Foundation
import XCTest

// MARK: Verification Calls


public func verify<DeclarationType: Declaration, InvocationType, ReturnType>(_ declaration: Mockable<DeclarationType, InvocationType, ReturnType>,
                                                                             file: StaticString = #file,
                                                                             line: UInt = #line) -> VerificationManager<DeclarationType, ReturnType> {
    return VerificationManager(context: declaration.context,
                               invocation: declaration.invocation,
                               sourceLocation: SourceLocation(file, line))
}

public func verify<ReturnType>(_ declaration: @autoclosure () throws -> ReturnType,
                               file: StaticString = #file,
                               line: UInt = #line) -> VerificationManager<Any?, ReturnType> {
    let invocations = InvocationsRecorder().startRecording {
        _ = try? declaration()
    }
    
    guard let record = invocations.result else {
        preconditionFailure("Failed to verify the records.")
    }
    
    return VerificationManager(context: record.context,
                               invocation: record.invocation,
                               sourceLocation: SourceLocation(file, line))
}

// MARK: Protocol Definition
protocol VerificationManagerProtocol {
    associatedtype ReturnType
    
    func returned(_ value: ReturnType) -> Self
    func wasCalled(_ times: Int) -> Self
    func wasNeverCalled() -> Self
}

// MARK: Verification Implementation

public class VerificationManager<DeclarationType, ReturnType: Equatable> : VerificationManagerProtocol {
    typealias ReturnType = ReturnType
    
    private var context: ContextContainer
    private var invocation: Invocation
    private var sourceLocation: SourceLocation
        
    public init(context: ContextContainer,
                invocation: Invocation,
                sourceLocation: SourceLocation) {
        self.context = context
        self.invocation = invocation
        self.sourceLocation = sourceLocation
    }
    
    @discardableResult
    public func returned(_ value: ReturnType) -> Self {
        verify(value: value)
        return self
    }
    
    @discardableResult
    public func wasCalled(_ times: Int = 1) -> Self {
        verify(times: times)
        return self
    }
    
    @discardableResult
    public func wasNeverCalled() -> Self {
        verify(times: 0)
        return self
    }
    
    private func verify(times: Int) {
        do {
            try expectation(times: times)
        } catch {
            XCTFail(error.localizedDescription,
                    file: sourceLocation.file,
                    line: sourceLocation.line)
        }
    }
    
    private func verify(value: ReturnType) {
        do {
            try returning(value: value)
        } catch {
            XCTFail(error.localizedDescription,
                    file: sourceLocation.file,
                    line: sourceLocation.line)
        }
    }
    
    private func returning(value: ReturnType) throws {
        let result = context
            .stubbing
            .stubs
            .filter { $0.key == invocation }
            .first
        
        guard let result = result else {
            throw TestFailure.foundNoResult(key: invocation.key)
        }
        
        guard let result = result.value as? ReturnType else {
            throw TestFailure.wrongReturnType(foundType: type(of: result), providedType: ReturnType.self)
        }
        
        guard result == value else {
            throw TestFailure.wrongValue(value: value, providedValue: result)
        }
    }
    
    private func expectation(times: Int) throws {
        let invocations = context
            .mocking
            .allInvocations.filter { $0 == invocation}
        
        /// ToDo -> Check against the members provided and if the members are different return an error
        /// ToDo -> Allow to pass any to the invocation in which case the members provided are ignored and only the key is checked

        guard times != invocations.count else { return }
        
        throw TestFailure.incorrectInvocationCount(expected: times,
                                                   received: invocations.count)
    }
}
