//
//  DiaryService.swift
//  
//
//  Created by Er Baghdasaryan on 23.11.24.
//

import UIKit
import CasinoCollectionModel
import SQLite

public protocol IDiaryService {
    func addNote(_ model: NoteModel) throws -> NoteModel
    func getNotes() throws -> [NoteModel]
    func deleteNote(byID id: Int) throws
    func addSale(_ model: SaleModel) throws -> SaleModel
    func getSales() throws -> [SaleModel]
    func getCollections() throws -> [CollectionModel]
}

public class DiaryService: IDiaryService {

    private let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!

    public init() { }

    public func addNote(_ model: NoteModel) throws -> NoteModel {
        let db = try Connection("\(path)/db.sqlite3")
        let notes = Table("Notes")
        let idColumn = Expression<Int>("id")
        let headerColumn = Expression<String>("header")
        let textColumn = Expression<String>("text")

        try db.run(notes.create(ifNotExists: true) { t in
            t.column(idColumn, primaryKey: .autoincrement)
            t.column(headerColumn)
            t.column(textColumn)
        })

        let rowId = try db.run(notes.insert(
            headerColumn <- model.title,
            textColumn <- model.text
        ))

        return NoteModel(id: Int(rowId),
                         title: model.title,
                         text: model.text)
    }

    public func getNotes() throws -> [NoteModel] {
        let db = try Connection("\(path)/db.sqlite3")
        let notes = Table("Notes")
        let idColumn = Expression<Int>("id")
        let headerColumn = Expression<String>("header")
        let textColumn = Expression<String>("text")

        var result: [NoteModel] = []

        for note in try db.prepare(notes) {

            let fetchedNote = NoteModel(id: note[idColumn],
                                        title: note[headerColumn],
                                        text: note[textColumn])

            result.append(fetchedNote)
        }

        return result
    }

    public func deleteNote(byID id: Int) throws {
        let db = try Connection("\(path)/db.sqlite3")
        let notes = Table("Notes")
        let idColumn = Expression<Int>("id")

        let noteToDelete = notes.filter(idColumn == id)
        try db.run(noteToDelete.delete())
    }

    public func addSale(_ model: SaleModel) throws -> SaleModel {
        let db = try Connection("\(path)/db.sqlite3")
        let sales = Table("Sales")
        let idColumn = Expression<Int>("id")
        let imageColumn = Expression<Data>("firstImage")
        let titleColumn = Expression<String>("title")
        let nominalValueColumn = Expression<String>("nominalValue")
        let salePriceColumn = Expression<String>("salePrice")
        let priceColumn = Expression<String>("price")

        try db.run(sales.create(ifNotExists: true) { t in
            t.column(idColumn, primaryKey: .autoincrement)
            t.column(imageColumn)
            t.column(titleColumn)
            t.column(nominalValueColumn)
            t.column(salePriceColumn)
            t.column(priceColumn)
        })

        guard let imageData = model.image.pngData() else {
            throw NSError(domain: "ImageConversionError", code: 1, userInfo: nil)
        }

        let rowId = try db.run(sales.insert(
            imageColumn <- imageData,
            titleColumn <- model.title,
            nominalValueColumn <- model.nominalValue,
            salePriceColumn <- model.salePrice,
            priceColumn <- model.price
        ))

        return SaleModel(id: Int(rowId),
                         firstImage: model.image,
                         title: model.title,
                         nominalValue: model.nominalValue,
                         salePrice: model.salePrice,
                         price: model.price)
    }

    public func getSales() throws -> [SaleModel] {
        let db = try Connection("\(path)/db.sqlite3")
        let sales = Table("Sales")
        let idColumn = Expression<Int>("id")
        let imageColumn = Expression<Data>("firstImage")
        let titleColumn = Expression<String>("title")
        let nominalValueColumn = Expression<String>("nominalValue")
        let salePriceColumn = Expression<String>("salePrice")
        let priceColumn = Expression<String>("price")

        var result: [SaleModel] = []

        for sale in try db.prepare(sales) {
            guard let image = UIImage(data: sale[imageColumn]) else {
                throw NSError(domain: "ImageConversionError", code: 2, userInfo: nil)
            }

            let fetchedSale = SaleModel(id: sale[idColumn],
                                        firstImage: image,
                                        title: sale[titleColumn],
                                        nominalValue: sale[nominalValueColumn],
                                        salePrice: sale[salePriceColumn],
                                        price: sale[priceColumn])

            result.append(fetchedSale)
        }

        return result
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

}
