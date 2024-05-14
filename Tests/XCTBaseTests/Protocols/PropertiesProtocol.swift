//
//  PropertiesProtocol.swift
//
//
//  Created by Lenard Pop on 23/03/2024.
//

import Foundation
import XCTMockable

@Mockable
protocol PropertiesProtocol {
    static var description: String { get }
    
    var product: Product { get set }
    var productTitle: String? { get set }
    var productDescription: String { get }
}
