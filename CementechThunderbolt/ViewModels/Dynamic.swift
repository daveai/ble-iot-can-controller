//
//  Dynamic.swift
//  CementechThunderbolt
//
//  Created by Debashis Banerjee on 12/10/17.
//  Copyright © 2017 Debashis Banerjee. All rights reserved.
//

import UIKit

class Dynamic<T> {
    typealias listener = (_ oldVal:T, _ newVal:T) -> ()
    var value: T {
        didSet {
            
        }
    }
    
    init(_ v: T) {
        value = v
    }
}
