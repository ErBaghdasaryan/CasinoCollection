//
//  MainService.swift
//  
//
//  Created by Er Baghdasaryan on 16.12.24.
//

import UIKit
import CasinoCollectionModel

public protocol IMainService {
    func getMainItems() -> [MainPresentationModel]
}

public class MainService: IMainService {
    public init() { }

    public func getMainItems() -> [MainPresentationModel] {
        [
            MainPresentationModel(image: "firstMain",
                                        description: "Play and win with us"),
            MainPresentationModel(image: "secondMain",
                                        description: "Rate our app in the AppStore")
        ]
    }
}
