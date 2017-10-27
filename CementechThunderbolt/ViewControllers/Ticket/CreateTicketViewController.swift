//
//  CreateTicketViewController.swift
//  CementechThunderbolt
//
//  Created by Debashis Banerjee on 09/10/17.
//  Copyright © 2017 Debashis Banerjee. All rights reserved.
//

import UIKit
import LayerUIExtention
import Bond
class CreateTicketViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    var createTicketViewModel:CreateTicketViewModel = CreateTicketViewModel()
    var picker = UIPickerView()
    var viewModel:EditTicketViewModel = EditTicketViewModel()
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet var customerName: CustomUITextField!
    @IBOutlet weak var locationName: CustomUITextField!
    @IBOutlet weak var address: CustomUITextField!
    @IBOutlet var signaturePopup: SignaturePopup!
    @IBOutlet weak var btnSignature: CustomUIButton!
    @IBOutlet var addNotePopup: AddNote!
    @IBOutlet weak var estimatedCubicYardage: CustomUITextField!
    @IBOutlet weak var costPerCubicYardage: CustomUITextField!
    @IBOutlet weak var additionalCost: CustomUITextField!
    @IBOutlet weak var totalPrice: CustomUITextField!
    @IBOutlet weak var statusField: UITextField!
    var status:[String] = ["Pending","Running","Completed"]
    var selectedState:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        picker.delegate = self
        picker.dataSource = self
        statusField.inputView = picker
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(donePicker(sender:)))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(donePicker(sender:)))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        statusField.inputAccessoryView = toolBar
        
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
        return status.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return status[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedState = status[row]
    }
    @IBAction func actionStateDropDown(_ sender: Any) {
        statusField.becomeFirstResponder()
    }
    @objc func donePicker (sender:UIBarButtonItem){
        statusField.text = selectedState
        statusField.resignFirstResponder()
    }
    @IBAction func btnUploadPicture(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
}
extension UIImagePickerController
{
    override open var shouldAutorotate: Bool {
        return true
    }
    override open var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return .all
    }
}
