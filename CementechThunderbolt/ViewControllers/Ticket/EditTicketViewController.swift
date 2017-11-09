//
//  EditTicketViewController.swift
//  CementechThunderbolt
//
//  Created by Debashis Banerjee on 11/10/17.
//  Copyright © 2017 Debashis Banerjee. All rights reserved.
//

import UIKit
import LayerUIExtention
import Bond
class EditTicketViewController: UIViewController, SignaturePopupDelegete, AddNotePopupDelegete, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
    override func viewDidLoad() {
        super.viewDidLoad()
        signaturePopup.delegate = self;
        addNotePopup.delegate = self;
        setUp(editTicketViewModel: self.viewModel)
        makeNotificationBarButton(viewController: self)
    }
    func setUp(editTicketViewModel:EditTicketViewModel){
        bindWithViewModel(viewModel: editTicketViewModel)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLayoutSubviews() {
        scrollView.contentSize = CGSize(width: containerView.frame.width, height: containerView.frame.width + 600.0)
    }
    @IBAction func actionAddNote(_ sender: Any) {
        addNotePopup.center = CGPoint(x: self.view.frame.size.width  / 2, y: self.view.frame.size.height / 2)
        self.view.addSubview(addNotePopup)
    }
    
    @IBAction func tempPrint(_ sender: Any) {
        
    }
    func didClose(signatureData: UIImage) {        
        
        btnSignature.setImage(signatureData, for: UIControlState.normal)
        signaturePopup.removeFromSuperview()
        
    }
    
    func didClear() {
        
    }
    
    func didDelete() {
        
    }
    @IBAction func actionOpenSignaturePopup(_ sender: Any) {
        signaturePopup.center = CGPoint(x: self.view.frame.size.width  / 2, y: self.view.frame.size.height / 2)
        self.view.addSubview(signaturePopup)
    }
    func bindWithViewModel(viewModel:EditTicketViewModel){
        viewModel.estimatedCubicYardage.bind(to:estimatedCubicYardage.reactive.text)
        viewModel.costPerCubicYardage.bind(to:costPerCubicYardage.reactive.text)
        viewModel.additionalCost.bind(to:additionalCost.reactive.text)
        viewModel.totalCost.bind(to: totalPrice.reactive.text)
        _ = self.estimatedCubicYardage.reactive.text.observeNext { (newValue) in
            if (newValue != nil && newValue != "" && Double(newValue!) != nil) {
                self.estimatedCubicYardage.textColor = .black
                viewModel.estimatedCubicYardage.value = newValue!
            } else {
                self.estimatedCubicYardage.textColor = .red
            }
        }
        _ = self.costPerCubicYardage.reactive.text.observeNext { (newValue) in
            if (newValue != nil && newValue != "" && Double(newValue!) != nil) {
                self.costPerCubicYardage.textColor = .black
                viewModel.costPerCubicYardage.value = newValue!
            } else {
                self.costPerCubicYardage.textColor = .red
            }
        }
        _ = self.additionalCost.reactive.text.observeNext { (newValue) in
            if (newValue != nil && newValue != "" && Double(newValue!) != nil) {
                self.additionalCost.textColor = .black
                viewModel.additionalCost.value = newValue!
            } else {
                self.additionalCost.textColor = .red
            }
        }
    }
    
    func didNoteAdded(note: String) {
        print(note)
        addNotePopup.removeFromSuperview()
    }
    
    func didAddNotePopupClose() {
        addNotePopup.removeFromSuperview()
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
extension String  {
    var isNumber : Bool {
        get{
            return !self.isEmpty && self.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
        }
    }
}
