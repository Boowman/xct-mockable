//
//  XCTMockProtocol.swift
//
//
//  Created by Lenard Pop on 19/02/2024.
//

public protocol XCTMockProtocol {
    static var context: ContextContainer { get set }
    var context: ContextContainer { get set }
}
