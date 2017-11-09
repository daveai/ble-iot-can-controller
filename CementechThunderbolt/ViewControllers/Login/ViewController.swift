//
//  ViewController.swift
//  CementechThunderbolt
//
//  Created by Debashis Banerjee on 05/10/17.
//  Copyright © 2017 Debashis Banerjee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // later in your class:
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let frame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        print("Key board y:", frame.origin.y)
        print("Login button y", self.btnLogin.frame.origin.y)
        if(self.btnLogin.frame.origin.y > frame.origin.y) {
            //need to liftup the scrollview
            let displacement = self.btnLogin.frame.origin.y - frame.origin.y;
            //adding some nitty padding bellow
            let totalDisplacement = displacement + 50
            self.scrollView.contentSize = CGSize(width: self.scrollView.contentSize.width, height: self.scrollView.contentSize.height + totalDisplacement)
            self.scrollView.setContentOffset(CGPoint(x: 0, y: totalDisplacement), animated: true);
        }
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

