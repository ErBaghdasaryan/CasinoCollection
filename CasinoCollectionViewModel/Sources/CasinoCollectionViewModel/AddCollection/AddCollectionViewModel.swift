//
//  AddCollectionViewModel.swift
//
//
//  Created by Er Baghdasaryan on 22.11.24.
//

import Foundation
import CasinoCollectionModel
import Combine

public protocol IAddCollectionViewModel {
    func loadData()
    var values: [String] { get set }
    func addCollection(model: CollectionModel)
}

public class AddCollectionViewModel: IAddCollectionViewModel {

    private let homeService: IHomeService
    public var activateSuccessSubject = PassthroughSubject<Bool, Never>()
    public var values: [String] = []

    public init(homeService: IHomeService, navigationModel: AddNavigationModel) {
        self.homeService = homeService
        self.activateSuccessSubject = navigationModel.activateSuccessSubject
    }

    public func loadData() {
        self.values =  self.homeService.getAddValues()
    }

    public func addCollection(model: CollectionModel) {
        do {
            _ = try self.homeService.addCollection(model)
            self.activateSuccessSubject.send(true)
        } catch {
            print(error)
        }
    }
}
