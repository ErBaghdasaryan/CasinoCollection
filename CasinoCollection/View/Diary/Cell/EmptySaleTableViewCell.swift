//
//  EmptySaleTableViewCell.swift
//  CasinoCollection
//
//  Created by Er Baghdasaryan on 23.11.24.
//

import UIKit
import CasinoCollectionModel
import Combine

final class EmptySaleTableViewCell: UITableViewCell, IReusableView {
    private let header = UILabel(text: "You don't have a collection",
                                 textColor: .white,
                                 font: UIFont(name: "SFProText-Bold", size: 22))
    private let subHeader = UILabel(text: "Add a collection before going to this page",
                                    textColor: .white,
                                    font: UIFont(name: "SFProText-Semibold", size: 17))
    private var labelsStack: UIStackView!

    public func setupUI() {

        self.backgroundColor = UIColor.white.withAlphaComponent(0.05)

        self.header.textAlignment = .center
        self.subHeader.textAlignment = .center

        self.layer.cornerRadius = 28

        self.labelsStack = UIStackView(arrangedSubviews: [self.header, self.subHeader],
                                       axis: .vertical,
                                       spacing: 4)
        addSubview(labelsStack)
        setupConstraints()
    }

    private func setupConstraints() {

        labelsStack.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(6)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.bottom.equalToSuperview().inset(6)
        }
    }
}
