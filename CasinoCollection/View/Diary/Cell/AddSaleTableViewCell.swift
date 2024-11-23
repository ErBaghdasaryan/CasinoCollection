//
//  AddSaleTableViewCell.swift
//  CasinoCollection
//
//  Created by Er Baghdasaryan on 23.11.24.
//

import UIKit
import CasinoCollectionModel

final class AddSaleTableViewCell: UITableViewCell, IReusableView {

    private let content = UIView()
    private let image = UIImageView()
    private let nominalValue = UILabel(text: "",
                                       textColor: .white,
                                       font: UIFont(name: "SFProText-Semibold", size: 11))
    private let price = UILabel(text: "",
                                textColor: .gray,
                                font: UIFont(name: "SFProText-Semibold", size: 16))
    private let header = UILabel(text: "",
                                 textColor: .white,
                                 font: UIFont(name: "SFProText-Semibold", size: 17))

    private func setupUI() {

        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.content.backgroundColor = UIColor.white.withAlphaComponent(0.05)
        self.content.layer.cornerRadius = 28
        self.selectionStyle = .none

        self.header.textAlignment = .left
        self.price.textAlignment = .left

        self.nominalValue.layer.masksToBounds = true
        self.nominalValue.layer.cornerRadius = 10
        self.nominalValue.backgroundColor = UIColor(hex: "#920A98")

        self.image.layer.masksToBounds = true
        self.image.layer.cornerRadius = 15

        self.layer.borderWidth = 0
        self.layer.borderColor = UIColor.clear.cgColor

        addSubview(content)
        content.addSubview(image)
        content.addSubview(header)
        content.addSubview(nominalValue)
        content.addSubview(price)
        setupConstraints()
    }

    private func setupConstraints() {
        content.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(2)
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.bottom.equalToSuperview().inset(2)
        }

        image.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(20)
            view.leading.equalToSuperview().offset(24)
            view.width.equalTo(47)
            view.height.equalTo(47)
        }

        header.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(20)
            view.leading.equalTo(image.snp.trailing).offset(16)
            view.trailing.equalToSuperview().inset(130)
            view.height.equalTo(22)
        }

        nominalValue.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(4)
            view.leading.equalTo(image.snp.trailing).offset(16)
            view.width.equalTo(69)
            view.height.equalTo(21)
        }

        price.snp.makeConstraints { view in
            view.centerY.equalToSuperview()
            view.leading.equalTo(header.snp.trailing).offset(16)
            view.trailing.equalToSuperview().inset(24)
            view.height.equalTo(21)
        }
    }

    public func setup(with model: SaleModel) {
        self.image.image = model.image
        self.nominalValue.text = model.nominalValue
        self.price.text = "$\(model.price)"
        self.header.text = model.title

        self.setupUI()
    }

    public func setSelectedState(_ isSelected: Bool) {
        self.content.layer.borderColor = isSelected ? UIColor(hex: "#920A98")!.cgColor : UIColor.clear.cgColor
        self.content.layer.borderWidth = isSelected ? 3 : 0
    }
}
