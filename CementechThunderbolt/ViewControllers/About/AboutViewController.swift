//
//  AboutViewController.swift
//  CementechThunderbolt
//
//  Created by Debashis  on 03/11/17.
//  Copyright © 2017 Debashis Banerjee. All rights reserved.
//

import UIKit
import LayerUIExtention
class AboutViewController: UIViewController {    
    @IBOutlet var featureRequestPopupView: CustomUIView!
    @IBOutlet weak var btnRequestAFeature: UIBarButtonItem!
    @IBOutlet var feedbackPopup: CustomUIView!
    var blurrEffectView:UIVisualEffectView!
    var effect:UIVisualEffect!
    override func viewDidLoad() {
        super.viewDidLoad()
        effect = UIBlurEffect(style: .light)
        blurrEffectView = UIVisualEffectView(effect: effect)
        blurrEffectView.frame = self.view.bounds
        self.blurrEffectView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped)))
    }
    @objc func tapped(){
        animateOut()
        animateFeedbackOut()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func actionRequestFeature(_ sender: Any) {
        animatedIn()
    }
    func animatedIn() {
        self.view.addSubview(blurrEffectView)
        self.view.addSubview(featureRequestPopupView)
        featureRequestPopupView.center = self.view.center
        featureRequestPopupView.alpha = 0
        self.blurrEffectView.effect = self.effect
        UIView.animate(withDuration: 0.4) {
            self.featureRequestPopupView.alpha = 1
        }
    }
    func animateOut(){
        self.blurrEffectView.effect = self.effect
        UIView.animate(withDuration: 0.4, animations: {
            self.featureRequestPopupView.alpha = 0
        }) { (isFinished) in
            self.blurrEffectView.effect = nil
            self.featureRequestPopupView.removeFromSuperview()
            self.blurrEffectView.removeFromSuperview()
        }
    }
    func animatedFeedbackIn() {
        self.view.addSubview(blurrEffectView)
        self.view.addSubview(feedbackPopup)
        feedbackPopup.center = self.view.center
        feedbackPopup.alpha = 0
        self.blurrEffectView.effect = self.effect
        UIView.animate(withDuration: 0.4) {
            self.feedbackPopup.alpha = 1
        }
    }
    func animateFeedbackOut(){
        self.blurrEffectView.effect = self.effect
        UIView.animate(withDuration: 0.4, animations: {
            self.feedbackPopup.alpha = 0
        }) { (isFinished) in
            self.blurrEffectView.effect = nil
            self.blurrEffectView.removeFromSuperview()
            self.feedbackPopup.removeFromSuperview()
        }
    }
    @IBAction func actionSend(_ sender: Any) {
        animateOut()
        animateFeedbackOut()
    }
    @IBAction func actionLeaveUsFeedBack(_ sender: Any) {
        animatedFeedbackIn()
    }
}
