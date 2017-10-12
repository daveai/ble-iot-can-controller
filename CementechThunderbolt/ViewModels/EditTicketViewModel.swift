//
//  EditTicketViewModel.swift
//  CementechThunderbolt
//
//  Created by Debashis Banerjee on 12/10/17.
//  Copyright © 2017 Debashis Banerjee. All rights reserved.
//

import UIKit
import LayerUIExtention
import ReactiveKit
import Bond
class EditTicketViewModel: NSObject {
    private var ticketModel:TicketModel!
    var customerName = Observable<String>("")
    init(ticketModel:TicketModel) {
        self.ticketModel = ticketModel
        customerName.value = ticketModel.customerName
        customerName.observeNext { newValue in
            
        }
    }
    
    
}
