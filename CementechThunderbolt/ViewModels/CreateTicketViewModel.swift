//
//  CreateTicketViewModel.swift
//  CementechThunderbolt
//
//  Created by Debashis Banerjee on 13/10/17.
//  Copyright © 2017 Debashis Banerjee. All rights reserved.
//

import UIKit
import Bond
class CreateTicketViewModel  {
    let customerName = Observable<String?>("")
    
    init() {
        customerName.value = "Bond"
        
        _ = customerName.observeNext {
            text in
            if let text = text {
                print(text)
            }
        }
    }
}
