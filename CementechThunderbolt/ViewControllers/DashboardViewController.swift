//
//  DashboardViewController.swift
//  CementechThunderbolt
//
//  Created by Debashis Banerjee on 06/10/17.
//  Copyright © 2017 Debashis Banerjee. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

    @IBOutlet weak var container: UIView!
    private lazy var summaryViewController: PilotViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Pilots", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "pilot") as! PilotViewController
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChildViewController(viewController)
        
        // Add Child View as Subview
        self.container.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = self.container.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParentViewController: self)
    }
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParentViewController: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParentViewController()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        add(asChildViewController: summaryViewController)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
