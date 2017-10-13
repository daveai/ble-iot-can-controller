//
//  EditTicketViewController.swift
//  CementechThunderbolt
//
//  Created by Debashis Banerjee on 11/10/17.
//  Copyright © 2017 Debashis Banerjee. All rights reserved.
//

import UIKit
import LayerUIExtention
class EditTicketViewController: UIViewController, SignaturePopupDelegete {
    var editTicketViewModel:EditTicketViewModel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet var customerName: CustomUITextField!
    @IBOutlet weak var locationName: CustomUITextField!
    @IBOutlet weak var address: CustomUITextField!
    @IBOutlet var signaturePopup: SignaturePopup!
    @IBOutlet weak var btnSignature: CustomUIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        signaturePopup.delegate = self;
    }
    func setUp(editTicketViewModel:EditTicketViewModel){
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLayoutSubviews() {
        scrollView.contentSize = CGSize(width: containerView.frame.width, height: containerView.frame.width + 600.0)
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
}
