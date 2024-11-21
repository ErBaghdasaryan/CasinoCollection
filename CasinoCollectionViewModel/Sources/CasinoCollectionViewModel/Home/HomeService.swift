//
//  HomeService.swift
//  
//
//  Created by Er Baghdasaryan on 21.11.24.
//

import UIKit
import CasinoCollectionModel

public protocol IHomeService {
    func getValues() -> [String]
}

public class HomeService: IHomeService {
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

}
