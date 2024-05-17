//
//  XCTAsyncThrowsTests.swift
//
//
//  Created by Lenard Pop on 14/05/2024.
//

import XCTest
import Foundation
import XCTMockable

@testable import XCTBaseTests

final class XCTPropertiesTests: XCTBaseTests {
    private let product = Product(
        id: "x125",
        title: "Title",
        date: Date(timeIntervalSince1970: 1708387889),
        price: 49.99
    )
    
    func test_primitive_assignment() throws {
        // Arrange
        given(propertiesMock.productDescription).willReturn("Some cool value")
        
        // Act
        let result = propertiesMock.productDescription
        
        // Assert
        XCTAssertEqual("Some cool value", result)
    }
    
    func test_product_assignment() throws {
        // Arrange
        given(propertiesMock.product).willReturn(product)
        
        // Act
        let result = propertiesMock.product
        
        // Assert
        XCTAssertEqual(product, result)
    }
    
    func test_nil_assignment() throws {
        // Arrange
        given(propertiesMock.productTitle).willReturn(nil)
        
        // Act
        let result = propertiesMock.productTitle
        
        // Assert
        XCTAssertNil(result)
    }
  
    ///
    /// MARK: W.I.P
    ///
//    func test_async_isAvailability() async throws {
//        // Arrange
//        given(try await propertiesMock.isAvailable).willReturn(true)
//
//        // Act
//        let result = try await propertiesMock.isAvailable
//        
//        // Assert
//        XCTAssertTrue(result)
//    }
}
