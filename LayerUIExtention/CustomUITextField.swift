//
//  CustomUITextField.swift
//  LayerUIExtention
//
//  Created by Debashis Banerjee on 10/10/17.
//  Copyright © 2017 Debashis Banerjee. All rights reserved.
//

import UIKit

@IBDesignable public class CustomUITextField: UITextField {

    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        
        didSet {
            
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            layer.borderColor = newValue?.cgColor
        }
        get {
            guard let color = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
    }
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: newValue!])
        }
    }
    
    @IBInspectable var placeHolderSize: UIFont? {
        get {
            return self.placeHolderSize
        }
        set {
            self.attributedPlaceholder = NSMutableAttributedString(string: self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedStringKey.font:UIFont(name: "", size: 0)!])
        }
    }
    
    
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var paddingLeft: CGFloat = 0
    @IBInspectable var paddingRight: CGFloat = 0
    @IBInspectable var paddingTop: CGFloat = 0
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + paddingLeft, y: bounds.origin.y + paddingTop, width: bounds.size.width - paddingLeft - paddingRight, height: bounds.size.height)
    }
    
    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    @IBInspectable var color: UIColor = UIColor.lightGray {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        if let image = leftImage {
            leftViewMode = UITextFieldViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = color
            leftView = imageView
        } else {
            leftViewMode = UITextFieldViewMode.never
            leftView = nil
        }
    }

}
