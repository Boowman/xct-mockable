//
//  PropertiesProtocol.swift
//
//
//  Created by Lenard Pop on 23/03/2024.
//

import Foundation
import XCTMockable

@Mockable
protocol PropertiesProtocol: Equatable {
    static var description: String { get }
    static var instance: Self { get }
    
    var shared: Self { get }
    var product: Product { get set }
    var productTitle: String? { get set }
    var productDescription: String { get }
}
