//
//  SelectorType.swift
//
//
//  Created by Lenard Pop on 26/02/2024.
//

public enum SelectorType {
    case method
    case getter
    case setter
    
    public func description() -> String {
        switch self {
        case .method: return "method"
        case .getter: return "getter"
        case .setter: return "setter"
        }
    }
}
