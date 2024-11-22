//
//  SystemTextField.swift
//  CasinoCollection
//
//  Created by Er Baghdasaryan on 22.11.24.
//

import UIKit

public class SystemTextField: UIView {
    let mainLabel: UILabel
    public var helperLabel: UILabel?
    public var textField: TextField

    public init(labelText: String,
                placeholder: String) {
        self.mainLabel = UILabel(text: labelText,
                                 textColor: .white.withAlphaComponent(0.7),
                                 font: UIFont(name: "SFProText-Regular", size: 13))

        self.textField = TextField(placeholder: placeholder)

        self.mainLabel.textAlignment = .left

        super.init(frame: .zero)

        self.addSubview(mainLabel)
        self.addSubview(textField)

        mainLabel.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.height.equalTo(18)
        }

        textField.snp.makeConstraints { view in
            view.top.equalTo(mainLabel.snp.bottom).offset(8)
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.height.equalTo(54)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
