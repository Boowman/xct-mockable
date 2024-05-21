//
//  AssociatedTypeTests.swift
//
//
//  Created by Lenard Pop on 19/05/2024.
//

import XCTest
import Foundation
import XCTMockable

@testable import XCTBaseTests

final class AssociatedTypeTests: XCTBaseTests {
    func test_array_assigned_successful() throws {
        // Arrange
        given(associatedTypeMock.products).willReturn(["Hello", "World"])
        
        // Act
        let result = associatedTypeMock.products
        
        // Assert
        XCTAssertEqual(["Hello", "World"], result)
    }
    
    func test_array_assigned_failure() throws {
        // Arrange
        given(associatedTypeMock.products).willReturn(["Hello"])
        
        // Act
        let result = associatedTypeMock.products
        
        // Assert
        XCTAssertNotEqual(["Hello", "World"], result)
    }
    
    func test_primitive_value() throws {
        // Arrange
        given(associatedTypeMock.product).willReturn(product)
        
        // Act
        let result = associatedTypeMock.product
        
        // Assert
        XCTAssertEqual(product, result)
    }
    
    func test_primitive_value_nil() throws {
        // Arrange
        given(associatedTypeMock.product).willReturn(nil)
        
        // Act
        let result = associatedTypeMock.product
        
        // Assert
        XCTAssertNil(result)
    }
    
    private let product = Product(
        id: "x125",
        title: "Title",
        date: Date(timeIntervalSince1970: 1708387889),
        price: 49.99
    )
}
