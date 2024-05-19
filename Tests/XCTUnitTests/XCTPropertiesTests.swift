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
    
    func test_self_get_successful() throws {
        // Arrange
        given(propertiesMock.shared).willReturn(propertiesMock)
        
        // Act
        let result = propertiesMock.shared
        
        // Assert
        XCTAssertEqual(propertiesMock, result)
    }
    
    func test_static_self_get_successful() throws {
        // Arrange
        given(PropertiesProtocolMock.instance).willReturn(propertiesMock)
        
        // Act
        let result = PropertiesProtocolMock.instance
        
        // Assert
        XCTAssertEqual(propertiesMock, result)
    }
    
    func test_static_self_get_unsuccessful() throws {
        // Arrange
        given(PropertiesProtocolMock.instance).willReturn(PropertiesClass())
        
        // Act
        let result = PropertiesProtocolMock.instance
        
        // Assert
        XCTAssertNotEqual(propertiesMock, result)
    }
    
    func test_get_self_failure() throws {
        // Arrange
        let compareTo: PropertiesProtocolMock = PropertiesClass()
        
        given(propertiesMock.shared).willReturn(compareTo)
        
        // Act
        let result = propertiesMock.shared
        
        // Assert
        XCTAssertNotEqual(propertiesMock, result)
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
    
    private let product = Product(
        id: "x125",
        title: "Title",
        date: Date(timeIntervalSince1970: 1708387889),
        price: 49.99
    )
    
    final class PropertiesClass: PropertiesProtocolMock { }
}
