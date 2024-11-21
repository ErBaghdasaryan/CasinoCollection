//
//  HomeViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 21.11.24.
//

import Foundation
import CasinoCollectionModel

public protocol IHomeViewModel {
    func loadData()
    var values: [String] { get set }
    var collection: [CollectionModel] { get set }
    func loadCollections()
}

public class HomeViewModel: IHomeViewModel {

    private let homeService: IHomeService
    public var values: [String] = []
    public var collection: [CollectionModel] = []

    public init(homeService: IHomeService) {
        self.homeService = homeService
    }

    public func loadData() {
        self.values =  self.homeService.getValues()
    }

    public func loadCollections() {
        print("Error")
    }
}
