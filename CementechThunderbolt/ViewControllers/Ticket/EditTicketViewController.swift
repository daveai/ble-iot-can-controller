//
//  EditTicketViewController.swift
//  CementechThunderbolt
//
//  Created by Debashis Banerjee on 11/10/17.
//  Copyright © 2017 Debashis Banerjee. All rights reserved.
//

import UIKit
import LayerUIExtention
class EditTicketViewController: UIViewController {
    var editTicketViewModel:EditTicketViewModel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet var customerName: CustomUITextField!
    @IBOutlet weak var locationName: CustomUITextField!
    @IBOutlet weak var address: CustomUITextField!
    @IBOutlet var signaturePopup: SignaturePopup!
    override func viewDidLoad() {
        super.viewDidLoad()
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
       self.view.addSubview(signaturePopup)
    }
}
