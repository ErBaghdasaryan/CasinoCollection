//
//  DetailAssembly.swift
//  CasinoCollection
//
//  Created by Er Baghdasaryan on 16.12.24.
//

import Foundation
import CasinoCollectionViewModel
import Swinject
import SwinjectAutoregistration

final class DetailAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(IDetailViewModel.self, initializer: DetailViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(IDetailService.self, initializer: DetailService.init)
    }
}
