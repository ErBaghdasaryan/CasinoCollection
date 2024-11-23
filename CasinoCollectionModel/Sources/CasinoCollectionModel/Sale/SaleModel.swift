//
//  SaleModel.swift
//  
//
//  Created by Er Baghdasaryan on 23.11.24.
//

import UIKit

public struct SaleModel {
    public let id: Int?
    public let image: UIImage
    public let title: String
    public let nominalValue: String
    public let salePrice: String
    public let price: String

    public init(id: Int? = nil, firstImage: UIImage, title: String, nominalValue: String, salePrice: String, price: String) {
        self.id = id
        self.image = firstImage
        self.title = title
        self.nominalValue = nominalValue
        self.salePrice = salePrice
        self.price = price
    }
}
