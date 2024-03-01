//
//  File.swift
//  
//
//  Created by Lenard Pop on 17/02/2024.
//

import Foundation
import XCTest
import XCTSharkMockable

class Testing: XCTestCase {
    
    var service = ServiceProtocolMock(apiKey: "")
    
    func testingFetchProducts() throws {
        // Arrange
        let products = [Product(id: "1", title: "", date: Date(), price: 1.0),
                       Product(id: "15", title: "", date: Date(), price: 5.0)]
        
        given(service.fetchProducts(id: "32")).willReturn(products)
        
        let viewModel = ViewModel(service: service)
        
        // Act
        viewModel.fetchProducts(id: "32")
        
        // Assert
        XCTAssertEqual(products, viewModel.results)
        verify(service.fetchProducts(id: "32")).returned(products).wasCalled()
    }
    
    func testingFetchProductDetails() async throws {
        // Arrange
        let product = Product(id: "1", title: "", date: Date(), price: 1.0)
        
        given(await service.fetchProductDetails(id: "32")).willReturn(product)
        
        let viewModel = ViewModel(service: service)
        
        // Act
        await viewModel.fetchProductDetails(id: "32")
        
        // Assert
        XCTAssertEqual(product, viewModel.product)
        verify(await service.fetchProductDetails(id: "32")).returned(product).wasCalled()
    }
    
    func testingAge10() throws {
        // Arrange
        given(self.service.age).willReturn(20)
        
        let viewModel = ViewModel(service: service)
        
        // Act
        viewModel.getAge()
        
        // Assert
        XCTAssertEqual(20, viewModel.age)
        verify(service.age).wasCalled()
    }
    
    func testingAge15() throws {
        // Arrange
        given(self.service.age).willReturn(15)
        
        let viewModel = ViewModel(service: service)
        
        // Act
        viewModel.getAge()
        
        // Assert
        XCTAssertEqual(15, viewModel.age)
        verify(service.age).returned(15).wasCalled(1)
    }
    
    func testingNameBell() throws {
        // Arrange
        given(self.service.name).willReturn("Bell")
        
        let viewModel = ViewModel(service: service)
        
        // Act
        viewModel.getName()
        
        // Assert
        XCTAssertEqual("Bell", viewModel.name)
        verify(service.name).returned("Bell").wasCalled()
    }
}

@Mockable
protocol ServiceProtocol {
    var age: Int { get }
    var name: String { get set }
    var product: Product { get set }
    
    init(apiKey: String)
    
    func fetchProducts(id: String) -> [Product]
    func fetchProductDetails(id: String) async -> Product
}

class ServiceProtocolMocks: ServiceProtocol, XCTSharkMockProtocol {
    public static var context = ContextContainer()
    public var context = ContextContainer()

    var age: Int {
        get {
            return self.context.mocking.didInvoke(XCTSharkMockable.Invocation(key: "var age: Int", 
                                                                              members: [])) { invocation in
                self.context.recordInvocation(invocation)
                let result = self.context.stubbing.implementation(for: invocation)
                
                if let result = result as? Int {
                    return result
                }
                
                fatalError("Failed to find a suitable result type.", file: #file, line: #line)
            }
        }
        set { }
    }
    
    var name: String {
        get {
            return self.context.mocking.didInvoke(XCTSharkMockable.Invocation(key: "var name: String",
                                                                              members: [])) { invocation in
                self.context.recordInvocation(invocation)
                let result = self.context.stubbing.implementation(for: invocation)
                
                if let result = result as? String {
                    return result
                }
                
                fatalError("Failed to find a suitable result type.", file: #file, line: #line)
            }
        }
        set { }
    }
    
    var product: Product {
        get {
            return self.context.mocking.didInvoke(XCTSharkMockable.Invocation(key: "var product: Product",
                                                                              members: [])) { invocation in
                self.context.recordInvocation(invocation)
                let result = self.context.stubbing.implementation(for: invocation)
                
                if let result = result as? Product {
                    return result
                }
                
                fatalError("Failed to find a suitable result type.", file: #file, line: #line)
            }
        }
        set { }
    }
    
    var products: Product {
        get {
        return self.context.mocking.didInvoke(XCTSharkMockable.Invocation(key: "var product: Product",
                                                                          members: [])) { invocation in
            self.context.recordInvocation(invocation)
            let result = self.context.stubbing.implementation(for: invocation)

            if let result = result as? Product {
                return result
            }

            fatalError("Failed to find a suitable result type.", file: #file, line: #line)
        }
    }
        set {
        }
    }
    
    required init(apiKey: String) { }
    
    public func fetchProducts(id: String) -> XCTSharkMockable.Mockable<XCTSharkMockable.FunctionDeclaration, [Product]> {
        return XCTSharkMockable.Mockable<XCTSharkMockable.FunctionDeclaration, [Product]>(context: context,
                                                                                          invocation: XCTSharkMockable.Invocation(key: "func fetchProducts(id: String) -> [Product]",
                                                                                                                                  members: [XCTSharkMockable.InvocationMember(base: id)]),
                                                                                          returnType: Swift.ObjectIdentifier(([Product]).self))
    }

    public func fetchProducts(id: String) -> [Product] {
        return self.context.mocking.didInvoke(XCTSharkMockable.Invocation(key: "func fetchProducts(id: String) -> [Product]",
                                                                          members: [XCTSharkMockable.InvocationMember(base: id)])) { invocation in
            
            let result = self.context.stubbing.implementation(for: invocation)
            if let result = result as? [Product] {
                return result
            }

            fatalError("Failed to find a suitable result type.", file: #file, line: #line)
        }
    }
    
    public func fetchProductDetails(id: String) async -> XCTSharkMockable.Mockable<XCTSharkMockable.FunctionDeclaration, Product> {
        return XCTSharkMockable.Mockable<XCTSharkMockable.FunctionDeclaration, Product>(context: context,
                                                                                          invocation: XCTSharkMockable.Invocation(key: "func fetchProductDetails(id: String) async -> Product",
                                                                                                                                  members: [XCTSharkMockable.InvocationMember(base: id)]),
                                                                                          returnType: Swift.ObjectIdentifier(([Product]).self))
    }

    public func fetchProductDetails(id: String) async -> Product {
        return self.context.mocking.didInvoke(XCTSharkMockable.Invocation(key: "func fetchProductDetails(id: String) async -> Product",
                                                                          members: [XCTSharkMockable.InvocationMember(base: id)])) { invocation in
            
            let result = self.context.stubbing.implementation(for: invocation)
            if let result = result as? Product {
                return result
            }

            fatalError("Failed to find a suitable result type.", file: #file, line: #line)
        }
    }
}

class ViewModel {
    var service: ServiceProtocol?
    
    var results = [Product]()
    var products = [String]()
    var age = 0
    var name = ""
    var product: Product?
    
    init() { }
    
    convenience init(service: ServiceProtocol) {
        self.init()
        self.service = service
    }
    
    func getAge() {
        if let service = service {
            self.age = service.age
        }
    }
    
    func getName() {
        if let service = service {
            self.name = service.name
        }
    }
    
    func fetchResults() {
//        self.results = self.service?.fetchResults() ?? []
    }
    
    func fetchProducts(id: String) {
        if let product = self.service?.fetchProducts(id: id) {
            self.results = product
        }
    }
    
    func fetchProductDetails(id: String) async {
        if let product = await self.service?.fetchProductDetails(id: id) {
            self.product = product
        }
    }
}
