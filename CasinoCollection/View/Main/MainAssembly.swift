//
//  MainAssembly.swift
//  CasinoCollection
//
//  Created by Er Baghdasaryan on 16.12.24.
//

import Foundation
import CasinoCollectionViewModel
import Swinject
import SwinjectAutoregistration

final class MainAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(IMainViewModel.self, initializer: MainViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(IMainService.self, initializer: MainService.init)
    }
}
