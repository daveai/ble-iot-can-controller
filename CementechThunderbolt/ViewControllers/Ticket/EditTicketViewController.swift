//
//  EditTicketViewController.swift
//  CementechThunderbolt
//
//  Created by Debashis Banerjee on 11/10/17.
//  Copyright © 2017 Debashis Banerjee. All rights reserved.
//

import UIKit

class EditTicketViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLayoutSubviews() {
        scrollView.contentSize = CGSize(width: containerView.frame.width, height: containerView.frame.width + 600.0)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
