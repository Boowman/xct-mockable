//
//  MockingContextProtocol.swift
//  
//
//  Created by Lenard Pop on 19/02/2024.
//

public protocol MockingContextProtocol {
    func didInvoke<ReturnType>(_ invocation: Invocation,
                               completion: @escaping (Invocation) -> ReturnType) -> ReturnType
    
    func invoke(_ invocation: Invocation)
}
