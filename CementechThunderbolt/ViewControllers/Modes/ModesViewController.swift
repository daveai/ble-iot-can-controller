//
//  ModesViewController.swift
//  CementechThunderbolt
//
//  Created by Debashis Banerjee on 16/10/17.
//  Copyright © 2017 Debashis Banerjee. All rights reserved.
//

import UIKit

class ModesViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        let path = Bundle.main.url(forResource: "index", withExtension: "html", subdirectory: "www")
        print(path!.path)
        let urlRequest = URLRequest(url: path!)
        webView.loadRequest(urlRequest)
        //self.webView.scrollView.isScrollEnabled = false
        makeNotificationBarButton(viewController: self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        webView.frame.size.height = 1
        webView.frame.size = self.webView.sizeThatFits(.zero)
        webView.scrollView.isScrollEnabled=true;
        webView.scalesPageToFit = true
    }
}
