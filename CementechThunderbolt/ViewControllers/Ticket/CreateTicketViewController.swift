//
//  CreateTicketViewController.swift
//  CementechThunderbolt
//
//  Created by Debashis Banerjee on 09/10/17.
//  Copyright © 2017 Debashis Banerjee. All rights reserved.
//

import UIKit
import LayerUIExtention
class CreateTicketViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var createTicketViewModel:CreateTicketViewModel = CreateTicketViewModel()
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerView: UIView!
    var picker = UIPickerView()
    @IBOutlet weak var txtMixDesign: CustomUITextField!
    @IBOutlet weak var state: CustomUITextField!
    @IBOutlet weak var cubicYardage: CustomUITextField!
    @IBOutlet weak var costPerYeardCube: CustomUITextField!
    @IBOutlet weak var additionalCost: CustomUITextField!
    @IBOutlet weak var totalCost: CustomUITextField!
    var states:[String] = ["CA","CT","AZ","HI"]
    var selectedState:String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        picker.delegate = self
        picker.dataSource = self
        state.inputView = picker
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(donePicker(sender:)))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(donePicker(sender:)))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        state.inputAccessoryView = toolBar
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLayoutSubviews() {
        scrollView.contentSize = CGSize(width: containerView.frame.width, height: containerView.frame.width + 600.0)
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return states.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return states[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedState = states[row]
    }
    @IBAction func actionStateDropDown(_ sender: Any) {
        state.becomeFirstResponder()
    }
    @objc func donePicker (sender:UIBarButtonItem){
        state.text = selectedState
        state.resignFirstResponder()
        
    }
    
    
}
