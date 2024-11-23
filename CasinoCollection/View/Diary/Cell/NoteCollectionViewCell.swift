//
//  NoteCollectionViewCell.swift
//  CasinoCollection
//
//  Created by Er Baghdasaryan on 23.11.24.
//

import UIKit
import SnapKit
import CasinoCollectionViewModel
import Combine

final class NoteCollectionViewCell: UICollectionViewCell, IReusableView {

    private var title = UILabel(text: "",
                                textColor: .white,
                                font: UIFont(name: "SFProText-Semibold", size: 17))
    private var text = UILabel(text: "",
                               textColor: .white.withAlphaComponent(0.7),
                                font: UIFont(name: "SFProText-Regular", size: 15))

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
        self.layer.cornerRadius = 28

        self.title.textAlignment = .left
        self.text.textAlignment = .left
        self.text.numberOfLines = 5

        self.addSubview(title)
        self.addSubview(text)
    }

    private func setupConstraints() {

        title.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(22)
        }

        text.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(100)
        }
    }

    public func setup(title: String, text: String) {
        self.title.text = title
        self.text.text = text
    }
}
