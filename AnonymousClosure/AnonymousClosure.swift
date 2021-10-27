//
//  AnonymousClosure.swift
//  AnonymousClosure
//
//  Created by Mabdu on 13/07/2021.
//

import Foundation
import UIKit

public class View {
    
    public init() {
        
    }
    public let table: UITableView = {
       let table = UITableView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
        table.backgroundColor = .black
        table.separatorStyle = .none
        return table
    }()
}
