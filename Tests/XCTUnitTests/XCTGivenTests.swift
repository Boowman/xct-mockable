//
//  XCTGivenTests.swift
//
//
//  Created by Lenard Pop on 20/02/2024.
//

import XCTest
import Foundation
import XCTMockable

@testable import XCTBaseTests

final class XCTGivenTests: XCTBaseTests {
    private let product = Product(
        id: "x125",
        title: "Title",
        date: Date(timeIntervalSince1970: 1708387889),
        price: 49.99
    )
    
    // MARK: Given Methods
    
    func test_fetchData() throws {
        // Arrange
        given(methodsMock.fetchData()).willReturn("Some data")
        
        // Act
        let result: String = methodsMock.fetchData()
        
        // Assert
        XCTAssertEqual("Some data", result)
    }
    
    func test_fetchProduct_productReturn() throws {
        // Arrange
        given(methodsMock.fetchProduct(id: 2)).willReturn(product)
        
        // Act
        let result: Product = methodsMock.fetchProduct(id: 2)
        
        // Assert
        XCTAssertEqual(product, result)
    }
    
    func test_fetchProduct_productsReturned() throws {
        // Arrange
        given(methodsMock.fetchProduct(id: 2, key: "2")).willReturn([product])
        
        // Act
        let result: [Product]? = methodsMock.fetchProduct(id: 2, key: "2")
        
        // Assert
        XCTAssertEqual([product], result)
    }

    func test_fetchDoesProductExist_productsReturnNil() throws {
        // Arrange
        given(methodsMock.fetchProduct(id: 2, key: "2")).willReturn(nil)
        
        // Act
        let result: [Product]? = methodsMock.fetchProduct(id: 2, key: "2")
        
        // Assert
        XCTAssertNil(result)
    }
    
    // MARK: Given Properties 
    
    func test_property_productType() throws {
        // Arrange
        given(propertiesMock.product).willReturn(product)
        
        // Act
        let result: Product = propertiesMock.product
        
        // Assert
        XCTAssertEqual(product, result)
    }
    
    func test_property_stringType() throws {
        // Arrange
        given(propertiesMock.productDescription).willReturn("Property Description")
        
        // Act
        let result: String = propertiesMock.productDescription
        
        // Assert
        XCTAssertEqual("Property Description", result)
    }
    
    func test_property_nil() throws {
        // Arrange
        given(propertiesMock.productTitle).willReturn(nil)
        
        // Act
        let result: String? = propertiesMock.productTitle
        
        // Assert
        XCTAssertNil(result)
    }
    
    func test_property_notNil() throws {
        // Arrange
        given(propertiesMock.productTitle).willReturn("Property Title")
        
        // Act
        let result: String? = propertiesMock.productTitle
        
        // Assert
        XCTAssertEqual("Property Title", result)
    }    
    
    // MARK: ToDo Not Fully Implemented
    func test_fetchContents_variadic_parameters() throws {
        // Arrange
        given(methodsMock.fetchContents("1", "2", "3")).willReturn([product])
        
        // Act
        let result: [Product]? = methodsMock.fetchContents("1", "2", "3")
        
        // Assert
        XCTAssertEqual([product], result)
    }
}
