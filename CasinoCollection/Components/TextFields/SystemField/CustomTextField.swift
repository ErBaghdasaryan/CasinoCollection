//
//  CustomTextField.swift
//  CasinoCollection
//
//  Created by Er Baghdasaryan on 22.11.24.
//

import UIKit

public class TextField: UITextField {

    public convenience init(placeholder: String) {
        self.init()
        self.placeholder = placeholder
        self.isSecureTextEntry = isSecureTextEntry
        self.layer.cornerRadius = 12
        self.backgroundColor = .white.withAlphaComponent(0.05)
        self.textColor = .white
        self.font = UIFont(name: "SFProText-Regular", size: 17)
        self.rightViewMode = .always

        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.2)])

        self.autocorrectionType = .no
        self.autocapitalizationType = .none
    }

    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 12, dy: 0)
    }

    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 12, dy: 0)
    }
    
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 12, dy: 0)
    }

    override public func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.rightViewRect(forBounds: bounds)
        
        if rect.origin.x.isNaN || rect.origin.x.isInfinite {
            rect.origin.x = bounds.width - rect.width
        } else {
            rect.origin.x -= 12
        }
    
        return rect
    }
}
