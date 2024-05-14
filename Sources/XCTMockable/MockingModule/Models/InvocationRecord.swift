//
//  InvocationRecord.swift
//
//
//  Created by Lenard Pop on 21/02/2024.
//

import Foundation

public struct InvocationRecord: Equatable {
    let context: ContextContainer
    let invocation: Invocation
    
    public static func == (lhs: InvocationRecord, rhs: InvocationRecord) -> Bool {
        return lhs.invocation == rhs.invocation
    }
}
