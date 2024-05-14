//
//  XCTThrowsTests.swift
//
//
//  Created by Lenard Pop on 20/02/2024.
//

import XCTest
import Foundation
import XCTMockable

@testable import XCTBaseTests

final class XCTThrowsTests: XCTBaseTests {
    private let product = Product(
        id: "x125",
        title: "Title",
        date: Date(timeIntervalSince1970: 1708387889),
        price: 49.99
    )
    
    func test_fetchData_stringReturn() throws {
        // Arrange
        given(try throwsMock.fetchData()).willReturn("Fetching Data")
        
        // Act
        let result: String = try throwsMock.fetchData()
        
        // Assert
        XCTAssertEqual("Fetching Data", result)
    }
    
    func test_fetchProduct_productReturn() throws {
        // Arrange
        given(try throwsMock.fetchProduct(id: 2)).willReturn(product)
        
        // Act
        let result: Product = try throwsMock.fetchProduct(id: 2)
        
        // Assert
        XCTAssertEqual(product, result)
    }
    
    func test_fetchProduct_productsReturn() throws {
        // Arrange
        given(try throwsMock.fetchProducts(ids: [2])).willReturn([product])
        
        // Act
        let result: [Product] = try throwsMock.fetchProducts(ids: [2])
        
        // Assert
        XCTAssertEqual([product], result)
    }
}
