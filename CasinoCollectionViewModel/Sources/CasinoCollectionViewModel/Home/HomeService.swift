//
//  HomeService.swift
//  
//
//  Created by Er Baghdasaryan on 21.11.24.
//

import UIKit
import CasinoCollectionModel
import SQLite

public protocol IHomeService {
    func getValues() -> [String]
    func getAddValues() -> [String]
    func addCollection(_ model: CollectionModel) throws -> CollectionModel
    func getCollections() throws -> [CollectionModel]
    func deleteCollection(byID id: Int) throws
    func editCollection(_ model: CollectionModel) throws
}

public class HomeService: IHomeService {

    private let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!

    public init() { }

    public func getValues() -> [String] {
        [
            "All",
            "$1",
            "$5",
            "$10",
            "$25",
            "$50",
            "$100", 
            "$500",
            "$1000",
            "$5000", 
            "$10000"
        ]
    }

    public func getAddValues() -> [String] {
        [
            "$1",
            "$5",
            "$10",
            "$25",
            "$50",
            "$100",
            "$500",
            "$1000",
            "$5000",
            "$10000"
        ]
    }

    public func addCollection(_ model: CollectionModel) throws -> CollectionModel {
        let db = try Connection("\(path)/db.sqlite3")
        let collections = Table("Collections")
        let idColumn = Expression<Int>("id")
        let firstImageColumn = Expression<Data>("firstImage")
        let secondImageColumn = Expression<Data>("secondImage")
        let thirdImageColumn = Expression<Data>("thirdImage")
        let fourthImageColumn = Expression<Data>("fourthImage")
        let titleColumn = Expression<String>("title")
        let addressColumn = Expression<String>("address")
        let nominalValueColumn = Expression<String>("nominalValue")
        let descriptionColumn = Expression<String>("description")
        let priceColumn = Expression<String>("price")

        try db.run(collections.create(ifNotExists: true) { t in
            t.column(idColumn, primaryKey: .autoincrement)
            t.column(firstImageColumn)
            t.column(secondImageColumn)
            t.column(thirdImageColumn)
            t.column(fourthImageColumn)
            t.column(titleColumn)
            t.column(addressColumn)
            t.column(nominalValueColumn)
            t.column(descriptionColumn)
            t.column(priceColumn)
        })

        guard let firstImageData = model.firstImage.pngData() else {
            throw NSError(domain: "ImageConversionError", code: 1, userInfo: nil)
        }
        guard let secondImageData = model.secondImage.pngData() else {
            throw NSError(domain: "ImageConversionError", code: 1, userInfo: nil)
        }
        guard let thirdImageData = model.thirdImage.pngData() else {
            throw NSError(domain: "ImageConversionError", code: 1, userInfo: nil)
        }
        guard let fourthImageData = model.fourthImage.pngData() else {
            throw NSError(domain: "ImageConversionError", code: 1, userInfo: nil)
        }

        let rowId = try db.run(collections.insert(
            firstImageColumn <- firstImageData,
            secondImageColumn <- secondImageData,
            thirdImageColumn <- thirdImageData,
            fourthImageColumn <- fourthImageData,
            titleColumn <- model.title,
            addressColumn <- model.address,
            nominalValueColumn <- model.nominalValue,
            descriptionColumn <- model.description,
            priceColumn <- model.price
        ))

        return CollectionModel(id: Int(rowId),
                               firstImage: model.firstImage,
                               secondImage: model.secondImage,
                               thirdImage: model.thirdImage,
                               fourthImage: model.fourthImage,
                               title: model.title,
                               address: model.address,
                               nominalValue: model.nominalValue,
                               description: model.description,
                               price: model.price)
    }

    public func getCollections() throws -> [CollectionModel] {
        let db = try Connection("\(path)/db.sqlite3")
        let collections = Table("Collections")
        let idColumn = Expression<Int>("id")
        let firstImageColumn = Expression<Data>("firstImage")
        let secondImageColumn = Expression<Data>("secondImage")
        let thirdImageColumn = Expression<Data>("thirdImage")
        let fourthImageColumn = Expression<Data>("fourthImage")
        let titleColumn = Expression<String>("title")
        let addressColumn = Expression<String>("address")
        let nominalValueColumn = Expression<String>("nominalValue")
        let descriptionColumn = Expression<String>("description")
        let priceColumn = Expression<String>("price")

        var result: [CollectionModel] = []

        for collection in try db.prepare(collections) {
            guard let firstImage = UIImage(data: collection[firstImageColumn]) else {
                throw NSError(domain: "ImageConversionError", code: 2, userInfo: nil)
            }
            guard let secondImage = UIImage(data: collection[secondImageColumn]) else {
                throw NSError(domain: "ImageConversionError", code: 2, userInfo: nil)
            }
            guard let thirdImage = UIImage(data: collection[thirdImageColumn]) else {
                throw NSError(domain: "ImageConversionError", code: 2, userInfo: nil)
            }
            guard let fourthImage = UIImage(data: collection[fourthImageColumn]) else {
                throw NSError(domain: "ImageConversionError", code: 2, userInfo: nil)
            }

            let fetchedCollection = CollectionModel(id: collection[idColumn],
                                                    firstImage: firstImage,
                                                    secondImage: secondImage,
                                                    thirdImage: thirdImage,
                                                    fourthImage: fourthImage,
                                                    title: collection[titleColumn],
                                                    address: collection[addressColumn],
                                                    nominalValue: collection[nominalValueColumn],
                                                    description: collection[descriptionColumn],
                                                    price: collection[priceColumn])

            result.append(fetchedCollection)
        }

        return result
    }

    public func editCollection(_ model: CollectionModel) throws {
        let db = try Connection("\(path)/db.sqlite3")
        let collections = Table("Collections")
        let idColumn = Expression<Int>("id")
        let firstImageColumn = Expression<Data>("firstImage")
        let secondImageColumn = Expression<Data>("secondImage")
        let thirdImageColumn = Expression<Data>("thirdImage")
        let fourthImageColumn = Expression<Data>("fourthImage")
        let titleColumn = Expression<String>("title")
        let addressColumn = Expression<String>("address")
        let nominalValueColumn = Expression<String>("nominalValue")
        let descriptionColumn = Expression<String>("description")
        let priceColumn = Expression<String>("price")

        guard let firstImageData = model.firstImage.pngData() else {
            throw NSError(domain: "ImageConversionError", code: 1, userInfo: nil)
        }
        guard let secondImageData = model.secondImage.pngData() else {
            throw NSError(domain: "ImageConversionError", code: 1, userInfo: nil)
        }
        guard let thirdImageData = model.thirdImage.pngData() else {
            throw NSError(domain: "ImageConversionError", code: 1, userInfo: nil)
        }
        guard let fourthImageData = model.fourthImage.pngData() else {
            throw NSError(domain: "ImageConversionError", code: 1, userInfo: nil)
        }

        let collectionToUpdate = collections.filter(idColumn == model.id!)
        try db.run(collectionToUpdate.update(
            firstImageColumn <- firstImageData,
            secondImageColumn <- secondImageData,
            thirdImageColumn <- thirdImageData,
            fourthImageColumn <- fourthImageData,
            titleColumn <- model.title,
            addressColumn <- model.address,
            nominalValueColumn <- model.nominalValue,
            descriptionColumn <- model.description,
            priceColumn <- model.price
        ))
    }

    public func deleteCollection(byID id: Int) throws {
        let db = try Connection("\(path)/db.sqlite3")
        let collections = Table("Collections")
        let idColumn = Expression<Int>("id")

        let collectionToDelete = collections.filter(idColumn == id)
        try db.run(collectionToDelete.delete())
    }

}
