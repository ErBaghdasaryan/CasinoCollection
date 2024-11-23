//
//  AddNoteAssembly.swift
//  CasinoCollection
//
//  Created by Er Baghdasaryan on 23.11.24.
//

import Foundation
import CasinoCollectionViewModel
import CasinoCollectionModel
import Swinject
import SwinjectAutoregistration

final class AddNoteAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(IAddNoteViewModel.self, argument: AddNavigationModel.self, initializer: AddNoteViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(IDiaryService.self, initializer: DiaryService.init)
    }
}
