//
//  AddColelctionAssembly.swift
//  CasinoCollection
//
//  Created by Er Baghdasaryan on 22.11.24.
//

import Foundation
import CasinoCollectionViewModel
import CasinoCollectionModel
import Swinject
import SwinjectAutoregistration

final class AddCollectionAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(IAddCollectionViewModel.self, argument: AddNavigationModel.self, initializer: AddCollectionViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(IHomeService.self, initializer: HomeService.init)
    }
}
