//
//  Setupable.swift
//  CasinoCollection
//
//  Created by Er Baghdasaryan on 21.11.24.
//

import Foundation

protocol ISetupable {
    associatedtype SetupModel
    func setup(with model: SetupModel)
}
