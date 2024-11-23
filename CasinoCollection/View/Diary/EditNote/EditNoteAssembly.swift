//
//  EditNoteAssembly.swift
//  CasinoCollection
//
//  Created by Er Baghdasaryan on 23.11.24.
//

import Foundation
import CasinoCollectionViewModel
import CasinoCollectionModel
import Swinject
import SwinjectAutoregistration

final class EditNoteAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(IEditNoteViewModel.self, argument: NoteNavigationModel.self, initializer: EditNoteViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(IDiaryService.self, initializer: DiaryService.init)
    }
}
