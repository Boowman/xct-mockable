//
//  File.swift
//  
//
//  Created by Lenard Pop on 20/02/2024.
//

import Foundation

protocol InvocationsRecorderProtocol {
    func recordInvocation(context: ContextContainer, invocation: Invocation)
}
