//
//  Context.swift
//
//
//  Created by Lenard Pop on 19/02/2024.
//

import Foundation

public class ContextContainer {
    public let mocking: MockingContext
    public let stubbing: StubbingContext
    
    public init(mocking: MockingContext = MockingContext(),
                stubbing: StubbingContext = StubbingContext()) {
        self.mocking = mocking
        self.stubbing = stubbing
    }
    
    public func recordInvocation(_ invocation: Invocation) {
        guard let recorder = InvocationsRecorder.sharedRecorder else { return }
        recorder.recordInvocation(context: self, invocation: invocation)
    }
}
