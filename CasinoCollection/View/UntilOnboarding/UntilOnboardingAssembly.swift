//
//  UntilOnboardingAssembly.swift
//  CasinoCollection
//
//  Created by Er Baghdasaryan on 21.11.24.
//

import Foundation
import CasinoCollectionModel
import CasinoCollectionViewModel
import Swinject
import SwinjectAutoregistration

final class UntilOnboardingAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(IUntilOnboardingViewModel.self, initializer: UntilOnboardingViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(IUntilOnboardingService.self, initializer: UntilOnboardingService.init)
    }
}
