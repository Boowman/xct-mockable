//
//  InvocationsRecorder.swift
//
//
//  Created by Lenard Pop on 20/02/2024.
//

import Foundation
import XCTBridge

public class InvocationsRecorder: NSObject {
    private static let sharedQueue = DispatchQueue(label: "com.xct.mockable.invocationsRecorder")
    
    enum Constants {
        static let recorderKey = DispatchSpecificKey<InvocationsRecorder>()
        static let exception = NSException(
            name: NSExceptionName(rawValue: "com.xct.mockable.invocationsRecorder.result"),
            reason: nil,
            userInfo: nil)
    }
    
    private(set) var result: InvocationRecord? {
        didSet {
            XCTThrowException(Constants.exception)
        }
    }
    
    public func startRecording(block: () -> Void) -> Self {
        Self.sharedQueue.sync {
            _ = XCTTryExceptionBlock {
                Self.sharedQueue.setSpecific(key: Constants.recorderKey, value: self)
                block()
            }
            
            Self.sharedQueue.setSpecific(key: Constants.recorderKey, value: nil)
        }
        
        return self
    }
    
    public func recordInvocation(context: ContextContainer,
                                 invocation: Invocation) {
        guard let result = result else {
            self.result = InvocationRecord(context: context, invocation: invocation)
            return
        }
        
        if result.invocation != invocation {
            self.result = InvocationRecord(context: context, invocation: invocation)
        }
    }
    
   public static var sharedRecorder: InvocationsRecorder? {
        return DispatchQueue.getSpecific(key: Constants.recorderKey)
    }
}
