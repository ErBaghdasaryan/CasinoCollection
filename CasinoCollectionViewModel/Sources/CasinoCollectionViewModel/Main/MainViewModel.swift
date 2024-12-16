//
//  MainViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 16.12.24.
//

import Foundation
import CasinoCollectionModel

public protocol IMainViewModel {
    var mainItems: [MainPresentationModel] { get set }
    func loadData()
}

public class MainViewModel: IMainViewModel {

    private let mainService: IMainService

    public var mainItems: [MainPresentationModel] = []

    public init(mainService: IMainService) {
        self.mainService = mainService
    }

    public func loadData() {
        mainItems = mainService.getMainItems()
    }
}
