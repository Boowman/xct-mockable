//
//  File.swift
//  
//
//  Created by Lenard Pop on 19/05/2024.
//

import Foundation
import XCTMockable

//@Mockable(itemId: String, itemType: Product)
@Mockable(("ItemId", String), ("ItemType", Product))
//@Mockable
protocol AssociatedTypeProtocol {
    associatedtype ItemId
    associatedtype ItemType
    
    var products: [ItemId] { get set }
    var product: ItemType? { get }
}

class AssociatedTypeMock: AssociatedTypeProtocol, XCTMockProtocol {
    typealias ItemId = String
    typealias ItemType = Product
    
    public var mockClassId = UUID()
    
    public static var context = XCTMockable.ContextContainer()
    public var context = XCTMockable.ContextContainer()
    
    var products: [ItemId] {
        get {
            return self.context.mocking.didInvoke(XCTMockable.Invocation(key: "var products: [ItemId]",
                                                                         members: [])) { invocation in
                self.context.recordInvocation(invocation)
                
                let result = self.context.stubbing.implementation(for: invocation)
                
                if let result = result {
                    if let result = result as? [ItemId] {
                        return result
                    }
                }
                
                fatalError("Failed to find a suitable result type.", file: #file, line: #line)
            }
        }
        set { }
    }
    
    var product: ItemType? {
        get {
            return self.context.mocking.didInvoke(XCTMockable.Invocation(key: "var product: ItemType?",
                                                                         members: [])) { invocation in
                self.context.recordInvocation(invocation)
                
                let result = self.context.stubbing.implementation(for: invocation)
                
                if let result = result {
                    if let result = result as? ItemType? {
                        return result
                    }
                    
                    return nil
                }
                
                fatalError("Failed to find a suitable result type.", file: #file, line: #line)
            }
        }
        set { }
    }
}
