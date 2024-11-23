//
//  AddSaleViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 23.11.24.
//

import Foundation
import CasinoCollectionModel
import Combine

public protocol IAddSaleViewModel {
    func loadSales()
    func addSale(model: SaleModel)
    var collections: [CollectionModel] { get set }
}

public class AddSaleViewModel: IAddSaleViewModel {

    private let diaryService: IDiaryService
    public var collections: [CollectionModel] = []
    public var activateSuccessSubject = PassthroughSubject<Bool, Never>()

    public init(diaryService: IDiaryService, navigationModel: AddNavigationModel) {
        self.diaryService = diaryService
        self.activateSuccessSubject = navigationModel.activateSuccessSubject
    }

    public func addSale(model: SaleModel) {
        do {
            _ = try self.diaryService.addSale(model)
            self.activateSuccessSubject.send(true)
        } catch {
            print(error)
        }
    }

    public func loadSales() {
        do {
            collections = try self.diaryService.getCollections()
        } catch {
            print(error)
        }
    }
}
