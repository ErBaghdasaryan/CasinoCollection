//
//  AddPhoto.swift
//  CasinoCollection
//
//  Created by Er Baghdasaryan on 22.11.24.
//

import UIKit
import CasinoCollectionModel

final class AddPhotoView: UIView {
    public let defaultImage = UIImageView(image: UIImage(named: "plus"))
    public var image = UIImageView()

    public init() {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {

        self.backgroundColor = UIColor.clear

        self.layer.cornerRadius = 12

        self.image.backgroundColor = .clear
        self.image.contentMode = .scaleToFill
        self.image.layer.masksToBounds = true
        self.image.layer.cornerRadius = 12

        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor

        addSubview(defaultImage)
        addSubview(image)
        setupConstraints()
    }

    private func setupConstraints() {
        defaultImage.snp.makeConstraints { view in
            view.centerY.equalToSuperview()
            view.centerX.equalToSuperview()
            view.width.equalTo(40)
            view.height.equalTo(32)
        }

        image.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.bottom.equalToSuperview()
        }
    }

    public func setup(with image: UIImage) {
        self.image = UIImageView(image: image)
        self.setupUI()
    }
}
