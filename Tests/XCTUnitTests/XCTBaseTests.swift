//
//  XCTBaseTests.swift
//
//
//  Created by Lenard Pop on 13/05/2024.
//

import Foundation
import XCTest

@testable import XCTBaseTests

internal class XCTBaseTests: XCTestCase {
    internal let asyncMock = AsyncProtocolMock()
    internal let throwsMock = ThrowsProtocolMock()
    internal let methodsMock = MethodsProtocolMock()
    internal let subscriptMock = SubscriptProtocolMock()
    internal let propertiesMock = PropertiesProtocolMock()
    internal let asyncThrowsMock = AsyncThrowsProtocolMock()
}
