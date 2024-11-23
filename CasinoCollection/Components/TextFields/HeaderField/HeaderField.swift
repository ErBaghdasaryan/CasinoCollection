//
//  HeaderField.swift
//  CasinoCollection
//
//  Created by Er Baghdasaryan on 23.11.24.
//

import UIKit

public class HeaderField: UITextField {

    public convenience init(placeholder: String,
                            sfPro: String = "Bold",
                            size: CGFloat = 28,
                            isCentered: Bool = false) {
        self.init()
        self.placeholder = placeholder
        self.isSecureTextEntry = isSecureTextEntry
        self.backgroundColor = .clear
        self.textColor = .white
        self.font = UIFont(name: "SFProText-\(sfPro)", size: size)
        self.rightViewMode = .always

        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.2)])

        self.autocorrectionType = .no
        self.autocapitalizationType = .none

        if isCentered {
            self.textAlignment = .center
            self.contentHorizontalAlignment = .center
        } else {
            self.textAlignment = .left
            self.contentHorizontalAlignment = .left
        }

    }

    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        if self.textAlignment == .center {
            return CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        } else {
            return bounds.insetBy(dx: 12, dy: 0)
        }
    }

    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        if self.textAlignment == .center {
            return CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        } else {
            return bounds.insetBy(dx: 12, dy: 0)
        }
    }
    
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        if self.textAlignment == .center {
            return CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        } else {
            return bounds.insetBy(dx: 12, dy: 0)
        }
    }

    override public func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.rightViewRect(forBounds: bounds)
        
        if rect.origin.x.isNaN || rect.origin.x.isInfinite {
            rect.origin.x = bounds.width - rect.width
        } else {
            rect.origin.x -= 14
        }
    
        return rect
    }
}
