//
//  CollectionViewModel.swift
//
//
//  Created by Er Baghdasaryan on 22.11.24.
//

import Foundation
import CasinoCollectionModel
import Combine

public protocol ICollectionViewModel {
    func loadData()
    var values: [String] { get set }
    var collections: [CollectionModel] { get set }
    var filteredCollections: [CollectionModel] { get set }
    func loadCollections()
    func filterCollection(with query: String)
    var activateSuccessSubject: PassthroughSubject<Bool, Never> { get }
}

public class CollectionViewModel: ICollectionViewModel {

    private let homeService: IHomeService
    public var values: [String] = []
    public var collections: [CollectionModel] = []
    public var filteredCollections: [CollectionModel] = []
    public var activateSuccessSubject = PassthroughSubject<Bool, Never>()

    public init(homeService: IHomeService) {
        self.homeService = homeService
    }

    public func loadData() {
        self.values =  self.homeService.getValues()
    }

    public func loadCollections() {
        do {
            self.collections = try self.homeService.getCollections()
            self.filteredCollections = collections
        } catch {
            print(error)
        }
    }

    public func filterCollection(with query: String) {
        if query == "All" {
            filteredCollections = collections
        } else {
            filteredCollections = collections.filter { $0.nominalValue.lowercased() == query.lowercased()}
        }
    }
}
