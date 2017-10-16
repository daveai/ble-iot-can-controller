//
//  DashboardViewController.swift
//  CementechThunderbolt
//
//  Created by Debashis Banerjee on 06/10/17.
//  Copyright © 2017 Debashis Banerjee. All rights reserved.
//

import UIKit
class DashboardViewController: UIViewController, MenuItemDelegate {
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var leftMenuView: LeftMenuView!
    var storyBoards = [
        StoryBoard(storyBoardName: "Ticket", display: "Ticket")
    ];
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
        //add(asChildViewController: summaryViewController)
        // Do any additional setup after loading the view.
        self.leftMenuView.menuItems = storyBoards
        leftMenuView.delegate = self
        
        let childViewController: UINavigationController = {
            // Load Storyboard
            let storyboard = UIStoryboard(name: storyBoards[0].storyBoardName, bundle: Bundle.main)
            // Instantiate View Controller
            let viewController = storyboard.instantiateInitialViewController() as! UINavigationController
            viewController.accessibilityValue = storyBoards[0].storyBoardName
            return viewController
        }()
        add(asChildViewController: childViewController)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Menu Item Delegates
    func didSelectMenu(menu: StoryBoard) {
        print(menu.storyBoardName);
        let childViewController: UINavigationController = {
            // Load Storyboard
            let storyboard = UIStoryboard(name: menu.storyBoardName, bundle: Bundle.main)
            // Instantiate View Controller
            let viewController = storyboard.instantiateInitialViewController() as! UINavigationController
            viewController.accessibilityValue = menu.storyBoardName
            return viewController
        }()
        print(self.childViewControllers);
        if(self.childViewControllers.count != 0){
            for child in self.childViewControllers {
                
                if(child.accessibilityValue as String! == childViewController.accessibilityValue as String!){
                    //do not add as child view just present it up
                    print("hello")
                    //break;
                } else {
                    add(asChildViewController: childViewController)
                }
            }
        } else {
            add(asChildViewController: childViewController)
        }
        
    }
    
}
