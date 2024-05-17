//
//  SubscriptProtocol.swift
//
//
//  Created by Lenard Pop on 28/04/2024.
//

import Foundation
import XCTMockable

@Mockable
protocol SubscriptProtocol {
    subscript(id: String, product: Product) -> Product? { get async throws }
    
    subscript(index: Int) -> String { get set }
    subscript(id: Int, key: Int) -> Int { get }
    subscript(product: Product) -> Product? { get }
}
