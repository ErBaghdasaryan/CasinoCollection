//
//  AddSaleAssembly.swift
//  CasinoCollection
//
//  Created by Er Baghdasaryan on 23.11.24.
//

import Foundation
import CasinoCollectionViewModel
import CasinoCollectionModel
import Swinject
import SwinjectAutoregistration

final class AddSaleAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(IAddSaleViewModel.self, argument: AddNavigationModel.self, initializer: AddSaleViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(IDiaryService.self, initializer: DiaryService.init)
    }
}
