//
//  StatisticView.swift
//  CasinoCollection
//
//  Created by Er Baghdasaryan on 21.11.24.
//

import UIKit
import CasinoCollectionModel

final class StatView: UIView {
    private let title = UILabel(text: "",
                                textColor: .white.withAlphaComponent(0.5),
                                font: UIFont(name: "SFProText-Regular", size: 13))
    private let count = UILabel(text: "0",
                                textColor: UIColor(hex: "#920A98")!,
                                font: UIFont(name: "SFProText-Bold", size: 28))
    private var isMoney: Bool

    public init(title: String, isMoney: Bool = false) {
        self.title.text = title
        self.isMoney = isMoney
        if isMoney {
            self.count.text = "$0"
        }
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {

        self.backgroundColor = UIColor.white.withAlphaComponent(0.05)

        self.layer.cornerRadius = 28

        self.title.numberOfLines = 2

        addSubview(count)
        addSubview(title)
        setupConstraints()
    }

    private func setupConstraints() {
        count.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(20)
            view.leading.equalToSuperview().offset(20)
            view.trailing.equalToSuperview().inset(20)
            view.height.equalTo(34)
        }

        title.snp.makeConstraints { view in
            view.top.equalTo(count.snp.bottom)
            view.leading.equalToSuperview().offset(20)
            view.trailing.equalToSuperview().inset(20)
            view.height.equalTo(36)
        }
    }

    public func setup(with count: String) {
        if isMoney {
            self.count.text = "\(count)$"
        } else {
            self.count.text = count
        }
        self.setupUI()
    }
}
