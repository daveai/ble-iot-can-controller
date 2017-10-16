//
//  EditTicketViewModel.swift
//  CementechThunderbolt
//
//  Created by Debashis Banerjee on 12/10/17.
//  Copyright © 2017 Debashis Banerjee. All rights reserved.
//

import UIKit
import LayerUIExtention
import Bond
class EditTicketViewModel {
    private var ticketModel:TicketModel!
    var customerName = Observable<String?>("")
    var locationName = Observable<String?>("")
    var address = Observable<String?>("")
    var city = Observable<String?>("")
    var state = Observable<String?>("")
    var mixDesign = Observable<String?>("")
    var details = Observable<String?>("")
    var estimatedCubicYardage = Observable<String?>("")
    var costPerCubicYardage = Observable<String?>("")
    var additionalCost = Observable<String?>("")
    var totalCost = Observable<String?>("")
    var paymentMethod = Observable<String?>("")
    
    init() {
        estimatedCubicYardage.value = "0"
        costPerCubicYardage.value = "0"
        additionalCost.value = "0"
        let totalCost = Double(estimatedCubicYardage.value!)! * Double(costPerCubicYardage.value!)! + Double(additionalCost.value!)!
        self.totalCost.value = String(totalCost)
        
        _ = estimatedCubicYardage.observeNext { value in
            if(value != nil && value != ""){
                let totalCost = Double(value!)! * Double(self.costPerCubicYardage.value!)! + Double(self.additionalCost.value!)!
                self.totalCost.value = String(totalCost)
            }
        }
        _ = costPerCubicYardage.observeNext { value in
            if(value != nil && value != ""){
                let totalCost = Double(value!)! * Double(self.estimatedCubicYardage.value!)! + Double(self.additionalCost.value!)!
                self.totalCost.value = String(totalCost)
            }
        }
        _ = additionalCost.observeNext { value in
            if(value != nil && value != ""){
                let totalCost = Double(self.costPerCubicYardage.value!)! * Double(self.estimatedCubicYardage.value!)! + Double(value!)!
                self.totalCost.value = String(totalCost)
            }
        }
        
    }
    
}
