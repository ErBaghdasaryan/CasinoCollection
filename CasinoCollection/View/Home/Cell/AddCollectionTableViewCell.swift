//
//  AddCollectionTableViewCell.swift
//  CasinoCollection
//
//  Created by Er Baghdasaryan on 22.11.24.
//

import UIKit
import CasinoCollectionModel

final class AddCollectionTableViewCell: UITableViewCell, IReusableView {

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
    private let descriptionLabel = UILabel(text: "",
                                           textColor: .white,
                                           font: UIFont(name: "SFProText-Regular", size: 15))

    private func setupUI() {

        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.content.backgroundColor = UIColor.white.withAlphaComponent(0.05)
        self.content.layer.cornerRadius = 28
        self.selectionStyle = .none

        self.header.textAlignment = .left
        self.descriptionLabel.textAlignment = .left
        self.descriptionLabel.numberOfLines = 3
        self.price.textAlignment = .right

        self.nominalValue.layer.masksToBounds = true
        self.nominalValue.layer.cornerRadius = 10
        self.nominalValue.backgroundColor = UIColor(hex: "#920A98")

        self.image.layer.masksToBounds = true
        self.image.layer.cornerRadius = 20

        addSubview(content)
        content.addSubview(image)
        content.addSubview(nominalValue)
        content.addSubview(price)
        content.addSubview(header)
        content.addSubview(descriptionLabel)
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
            view.width.equalTo(114)
            view.height.equalTo(114)
        }

        nominalValue.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(20)
            view.leading.equalTo(image.snp.trailing).offset(16)
            view.width.equalTo(69)
            view.height.equalTo(21)
        }

        price.snp.makeConstraints { view in
            view.centerY.equalTo(nominalValue.snp.centerY)
            view.trailing.equalToSuperview().inset(24)
            view.height.equalTo(21)
            view.width.equalTo(80)
        }

        header.snp.makeConstraints { view in
            view.top.equalTo(nominalValue.snp.bottom).offset(4)
            view.leading.equalTo(image.snp.trailing).offset(16)
            view.trailing.equalToSuperview().inset(24)
            view.height.equalTo(21)
        }

        descriptionLabel.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(8)
            view.leading.equalTo(image.snp.trailing).offset(16)
            view.trailing.equalToSuperview().inset(24)
            view.height.equalTo(59)
        }
    }

    public func setup(with model: CollectionModel) {
        self.image.image = model.firstImage
        self.nominalValue.text = model.nominalValue
        self.price.text = "$\(model.price)"
        self.header.text = model.title
        self.descriptionLabel.text = model.description

        self.setupUI()
    }
}
