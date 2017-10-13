//
//  SignaturePopup.swift
//  CementechThunderbolt
//
//  Created by Debashis Banerjee on 13/10/17.
//  Copyright © 2017 Debashis Banerjee. All rights reserved.
//

import UIKit
protocol SignaturePopupDelegete {
    func didClose(signatureData:UIImage)
    func didClear()
    func didDelete()
}
class SignaturePopup: UIView {
    var delegate:SignaturePopupDelegete!
    
    @IBOutlet weak var signatureCanvas: YPDrawSignatureView!
    
    var contentView:UIView?
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func xibSetup() {
        contentView = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        contentView!.frame = bounds
        
        // Make the view stretch with containing view
        contentView!.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(contentView!)
        
        
    }
    
    func loadViewFromNib() -> UIView! {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        let border = CALayer()
        border.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.17).cgColor
        border.frame = CGRect(x: self.frame.size.width - 1, y: 0, width: 1.0, height: view.frame.size.height)
        view.layer.addSublayer(border)
        return view
    }
    
    @IBAction func actionClear(_ sender: Any) {
        signatureCanvas.clear()
        delegate.didClear()
    }
    @IBAction func actionDelete(_ sender: Any) {
        
        delegate.didDelete()
    }
    @IBAction func actionClose(_ sender: Any) {
        let signatureData = signatureCanvas.getSignature()
        delegate.didClose(signatureData: signatureData!)
    }
}
