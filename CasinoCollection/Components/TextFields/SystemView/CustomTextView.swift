//
//  CustomTextView.swift
//  CasinoCollection
//
//  Created by Er Baghdasaryan on 22.11.24.
//

import UIKit

public class TextView: UITextView, UITextViewDelegate {

    private var placeholderText: String = ""
    public var placeholderLabel: UILabel = UILabel()

    public convenience init(placeholder: String) {
        self.init()
        self.placeholderText = placeholder

        configure()
    }

    private func configure() {
        self.layer.cornerRadius = 12
        self.backgroundColor = .white.withAlphaComponent(0.05)

        placeholderLabel.text = placeholderText
        placeholderLabel.font = UIFont(name: "SFProText-Regular", size: 17)
        placeholderLabel.sizeToFit()
        placeholderLabel.frame.origin = CGPoint(x: 16, y: 16)
        addSubview(placeholderLabel)
        placeholderLabel.isHidden = !text.isEmpty

        self.placeholderLabel.attributedText = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.2)])

        self.textColor = .white
        self.font = UIFont(name: "SFProText-Regular", size: 17)
        self.textContainerInset = UIEdgeInsets(top: 16, left: 12, bottom: 0, right: 0)

        self.delegate = self
    }

    // MARK: UITextViewDelegate
    public func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
}
