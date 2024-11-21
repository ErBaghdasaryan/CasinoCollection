//
//  ValueCollectionViewCell.swift
//  CasinoCollection
//
//  Created by Er Baghdasaryan on 22.11.24.
//

import UIKit
import SnapKit
import CasinoCollectionViewModel
import Combine

final class ValueCollectionViewCell: UICollectionViewCell, IReusableView {

    private var title = UILabel(text: "",
                                textColor: .white.withAlphaComponent(0.2),
                                font: UIFont(name: "SFProText-Semibold", size: 15))

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupConstraints()
    }

    private func setupUI() {
        self.backgroundColor = .white.withAlphaComponent(0.05)
        self.layer.cornerRadius = 20

        title.clipsToBounds = true
        title.numberOfLines = 0

        self.addSubview(title)
    }

    private func setupConstraints() {

        title.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(12)
        }
    }

    public func setup(title: String) {
        self.title.text = title
    }

    func setSelectedState(isSelected: Bool) {
        self.backgroundColor = isSelected ? UIColor(hex: "#920A98") : .white.withAlphaComponent(0.05)
        title.textColor = isSelected ? .white : .white.withAlphaComponent(0.2)
    }
}
