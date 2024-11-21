//
//  TabBar.swift
//  CasinoCollection
//
//  Created by Er Baghdasaryan on 21.11.24.
//

import UIKit

extension UITabBar {
    private struct AssociatedKeys {
        static var customHeight: CGFloat = 108.0
    }

    var customHeight: CGFloat {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.customHeight) as? CGFloat ?? 108.0
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.customHeight, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            invalidateIntrinsicContentSize()
            layoutIfNeeded()
        }
    }

    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = customHeight
        return sizeThatFits
    }
}
