//
//  TestFailure.swift
//  
//
//  Created by Lenard Pop on 19/02/2024.
//

import Foundation

enum TestFailure: Error, LocalizedError {
    case incorrectInvocationCount(expected: Int, received: Int)
    case foundNoResult(key: String)
    case wrongReturnType(foundType: Any.Type, providedType: Any.Type)
    case wrongValue(value: Any, providedValue: Any)
    
    public var errorDescription: String? {
        switch self {
        case let .incorrectInvocationCount(expected, received):
            return NSLocalizedString(
                """
                Invocation mismatch was expecting `\(expected)` but received `\(received)`
                """,
                comment: "Invocation mismatch"
            )
        case .wrongReturnType(foundType: let foundType, providedType: let providedType):
            return NSLocalizedString(
                """
                Found object has wrong type `\(foundType)` but received `\(providedType)`
                """,
                comment: "Found object has wrong type"
            )
        case .wrongValue(value: let val, providedValue: let providedVal):
            return NSLocalizedString(
                """
                The value that we found is different than what was provided:
                
                `\(val)`
                
                Is not equal to
                
                `\(providedVal)`
                """,
                comment: "Wrong value found"
            )
        case .foundNoResult(key: let key):
            return NSLocalizedString(
                """
                Found no object with the key `\(key)`
                """,
                comment: "Object not found"
            )
        }
    }
}
