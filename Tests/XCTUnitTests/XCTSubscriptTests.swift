//
//  XCTSubscriptTests.swift
//
//
//  Created by Lenard Pop on 12/05/2024.
//

import XCTest
import Foundation
import XCTMockable

@testable import XCTBaseTests

final class XCTSubscriptTests: XCTBaseTests {
    private let product = Product(
        id: "x125",
        title: "Title",
        date: Date(timeIntervalSince1970: 1708387889),
        price: 49.99
    )
    
    func test_subscriptKey_Int() throws {
        // Arrange
        given(subscriptMock[0]).willReturn("Some data")
        
        // Act
        let result: String = subscriptMock[0]
        
        // Assert
        XCTAssertEqual("Some data", result)
    }    
    
    func test_subscriptKey_Int_String() throws {
        // Arrange
        given(subscriptMock[0, 2]).willReturn(2)
        
        // Act
        let result: Int = subscriptMock[0, 2]
        
        // Assert
        XCTAssertEqual(2, result)
    }
    
    func test_subscriptKey_Object() throws {
        // Arrange
        let passProduct = Product(
            id: "x1",
            title: "Titles",
            date: Date(timeIntervalSince1970: 1708387889),
            price: 49.99
        )
        
        given(subscriptMock[passProduct]).willReturn(product)
        
        // Act
        let result: Product? = subscriptMock[passProduct]
        
        // Assert
        XCTAssertEqual(product, result)
    }
    
    func test_subscriptKey_returnNil() throws {
        // Arrange
        given(subscriptMock[product]).willReturn(nil)
        
        // Act
        let result: Product? = subscriptMock[product]
        
        // Assert
        XCTAssertNil(result)
    }
}
