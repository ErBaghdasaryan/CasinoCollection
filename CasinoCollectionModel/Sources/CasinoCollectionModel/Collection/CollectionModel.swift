//
//  CollectionModel.swift
//
//
//  Created by Er Baghdasaryan on 22.11.24.
//

import UIKit

public struct CollectionModel {
    public let id: Int?
    public let firstImage: UIImage
    public let secondImage: UIImage
    public let thirdImage: UIImage
    public let fourthImage: UIImage
    public let title: String
    public let address: String
    public let nominalValue: String
    public let description: String
    public let price: String

    public init(id: Int? = nil,
                firstImage: UIImage,
                secondImage: UIImage,
                thirdImage: UIImage,
                fourthImage: UIImage,
                title: String,
                address: String,
                nominalValue: String,
                description: String,
                price: String) {
        self.id = id
        self.firstImage = firstImage
        self.secondImage = secondImage
        self.thirdImage = thirdImage
        self.fourthImage = fourthImage
        self.title = title
        self.address = address
        self.nominalValue = nominalValue
        self.description = description
        self.price = price
    }
}
