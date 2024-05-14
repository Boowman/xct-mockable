//
//  InvocationMember.swift
//
//
//  Created by Lenard Pop on 19/02/2024.
//

public class InvocationMember: Equatable, Hashable {
    private var base: Any?
    private var baseType: Any?
    
    private let comparator: (_ lhs: Any?, _ rhs: Any?) -> Bool
    private let hashedValue: () -> Int


    public init<T: Equatable>(base: T?,
                              baseType: Any? = nil) {
        self.base = base
        self.baseType = type(of: base)
        
        self.comparator = { base == $1 as? T }
        self.hashedValue = { base.debugDescription.hashValue }
    }
    
    public func compare(with rhs: Any?) -> Bool {
      return comparator(base, rhs)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashedValue())
    }
    
    public static func == (lhs: InvocationMember, rhs: InvocationMember) -> Bool {
        return lhs.compare(with: rhs.base)
    }
}
