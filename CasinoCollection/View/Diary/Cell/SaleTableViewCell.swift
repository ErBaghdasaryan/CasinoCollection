//
//  SaleTableViewCell.swift
//  CasinoCollection
//
//  Created by Er Baghdasaryan on 23.11.24.
//

import UIKit
import CasinoCollectionModel

final class SaleTableViewCell: UITableViewCell, IReusableView {

    private let content = UIView()
    private let image = UIImageView()
    private let nominalValue = UILabel(text: "",
                                       textColor: .white,
                                       font: UIFont(name: "SFProText-Semibold", size: 11))
    private let price = UILabel(text: "",
                                textColor: .gray,
                                font: UIFont(name: "SFProText-Semibold", size: 16))
    private let salePrice = UILabel(text: "",
                                textColor: UIColor(hex: "#920A98")!,
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
        self.salePrice.textAlignment = .left

        self.nominalValue.layer.masksToBounds = true
        self.nominalValue.layer.cornerRadius = 10
        self.nominalValue.backgroundColor = UIColor(hex: "#920A98")

        self.image.layer.masksToBounds = true
        self.image.layer.cornerRadius = 15

        addSubview(content)
        content.addSubview(image)
        content.addSubview(header)
        content.addSubview(nominalValue)
        content.addSubview(salePrice)
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

        salePrice.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(20)
            view.leading.equalTo(header.snp.trailing).offset(16)
            view.trailing.equalToSuperview().inset(24)
            view.height.equalTo(21)
        }

        price.snp.makeConstraints { view in
            view.top.equalTo(salePrice.snp.bottom).offset(6)
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
        self.salePrice.text = "$\(model.salePrice)"

        self.setupUI()
    }
}
