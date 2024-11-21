//
//  EmptyTableViewCell.swift
//  CasinoCollection
//
//  Created by Er Baghdasaryan on 22.11.24.
//

import UIKit
import CasinoCollectionModel
import Combine

final class EmptyCell: UITableViewCell, IReusableView {
    private let image = UIImageView(image: .init(named: "emptyImage"))
    private let header = UILabel(text: "Empty",
                                 textColor: .white,
                                 font: UIFont(name: "SFProText-Bold", size: 22))
    private let subHeader = UILabel(text: "There are no records",
                                    textColor: .white,
                                    font: UIFont(name: "SFProText-Semibold", size: 17))
    private var labelsStack: UIStackView!
    private let addButton = UIButton(type: .system)

    public var addSubject = PassthroughSubject<Bool, Never>()
    var cancellables = Set<AnyCancellable>()

    override func prepareForReuse() {
        super.prepareForReuse()
        cancellables.removeAll()
    }

    public func setupUI() {

        self.backgroundColor = UIColor.white.withAlphaComponent(0.05)
        self.selectionStyle = .none

        self.header.textAlignment = .left
        self.subHeader.textAlignment = .left

        self.layer.cornerRadius = 28

        self.labelsStack = UIStackView(arrangedSubviews: [self.header, self.subHeader],
                                       axis: .vertical,
                                       spacing: 4)

        self.addButton.setTitle("Add an entry", for: .normal)
        self.addButton.setTitleColor(UIColor.white, for: .normal)
        self.addButton.layer.cornerRadius = 12
        self.addButton.layer.masksToBounds = true
        self.addButton.backgroundColor = UIColor(hex: "#920A98")

        addSubview(image)
        addSubview(labelsStack)
        addSubview(addButton)
        setupConstraints()
        makeButtonActions()
    }

    private func setupConstraints() {
        image.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(20)
            view.leading.equalToSuperview().offset(31)
            view.width.equalTo(120)
            view.height.equalTo(120)
        }

        labelsStack.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(53)
            view.leading.equalTo(image.snp.trailing).offset(16)
            view.trailing.equalToSuperview().inset(31)
            view.height.equalTo(54)
        }

        addButton.snp.makeConstraints { view in
            view.top.equalTo(labelsStack.snp.bottom).offset(41)
            view.leading.equalToSuperview().offset(24)
            view.trailing.equalToSuperview().inset(24)
            view.height.equalTo(50)
        }
    }
}

extension EmptyCell {
    private func makeButtonActions() {
        self.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }

    @objc func addButtonTapped() {
        self.addSubject.send(true)
    }
}
