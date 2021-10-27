//
//  Product.swift
//  HashableEqutable
//
//  Created by Mabdu on 13/07/2021.
//

import Foundation

public class Option {
    public let name: String
    public let value: String
    
    public init(name: String, value: String) {
        self.name = name
        self.value = value
    }
}

public class Product: Hashable {
    public var option: Option
    
    public init(option: Option) {
        self.option = option
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(option.name)
    }
    public static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.option.name == rhs.option.name && lhs.option.value == rhs.option.value
    }
    
}
