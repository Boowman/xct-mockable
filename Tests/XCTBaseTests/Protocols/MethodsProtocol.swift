//
//  MethodsProtocol.swift
//
//
//  Created by Lenard Pop on 23/03/2024.
//

import Foundation
import XCTMockable

@Mockable
protocol MethodsProtocol {
    func fetchProduct(id: Int, key: String) -> [Product]?
    func fetchProduct(id: Int) -> Product
    func fetchData() -> String
    func fetchContents(_ ids: String...) -> [Product]?
    func update(id: String)
}
