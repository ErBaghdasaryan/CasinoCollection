//
//  EditCollectionViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 22.11.24.
//

import Foundation
import CasinoCollectionModel
import Combine

public protocol IEditCollectionViewModel {
    func loadData()
    var values: [String] { get set }
    var collection: CollectionModel { get set }
    func editCollection(model: CollectionModel)
}

public class EditCollectionViewModel: IEditCollectionViewModel {

    private let homeService: IHomeService
    public var activateSuccessSubject = PassthroughSubject<Bool, Never>()
    public var values: [String] = []
    public var collection: CollectionModel

    public init(homeService: IHomeService, navigationModel: CollectionNavigationModel) {
        self.homeService = homeService
        self.activateSuccessSubject = navigationModel.activateSuccessSubject
        self.collection = navigationModel.model
    }

    public func loadData() {
        self.values =  self.homeService.getAddValues()
    }

    public func editCollection(model: CollectionModel) {
        do {
            try self.homeService.editCollection(model)
            self.activateSuccessSubject.send(true)
        } catch {
            print(error)
        }
    }
}
