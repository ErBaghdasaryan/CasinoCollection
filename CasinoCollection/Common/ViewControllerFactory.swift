//
//  ViewControllerFactory.swift
//  CasinoCollection
//
//  Created by Er Baghdasaryan on 21.11.24.
//

import Foundation
import Swinject
import CasinoCollectionModel
import CasinoCollectionViewModel

final class ViewControllerFactory {
    private static let commonAssemblies: [Assembly] = [ServiceAssembly()]

    //MARK: - UntilOnboarding
    static func makeUntilOnboardingViewController() -> UntilOnboardingViewController {
        let assembler = Assembler(commonAssemblies + [UntilOnboardingAssembly()])
        let viewController = UntilOnboardingViewController()
        viewController.viewModel = assembler.resolver.resolve(IUntilOnboardingViewModel.self)
        return viewController
    }

    //MARK: Onboarding
    static func makeOnboardingViewController() -> OnboardingViewController {
        let assembler = Assembler(commonAssemblies + [OnboardingAssembly()])
        let viewController = OnboardingViewController()
        viewController.viewModel = assembler.resolver.resolve(IOnboardingViewModel.self)
        return viewController
    }

    //MARK: Home
    static func makeHomeViewController() -> HomeViewController {
        let assembler = Assembler(commonAssemblies + [HomeAssembly()])
        let viewController = HomeViewController()
        viewController.viewModel = assembler.resolver.resolve(IHomeViewModel.self)
        return viewController
    }

    //MARK: Settings
    static func makeSettingsViewController() -> SettingsViewController {
        let assembler = Assembler(commonAssemblies + [SettingsAssembly()])
        let viewController = SettingsViewController()
        viewController.viewModel = assembler.resolver.resolve(ISettingsViewModel.self)
        return viewController
    }

    static func makeUsageViewController() -> UsageViewController {
        let viewController = UsageViewController()
        return viewController
    }

    //MARK: Collection
    static func makeCollectionViewController() -> CollectionViewController {
        let assembler = Assembler(commonAssemblies + [CollectionAssembly()])
        let viewController = CollectionViewController()
        viewController.viewModel = assembler.resolver.resolve(ICollectionViewModel.self)
        return viewController
    }

    //MARK: AddCollection
    static func makeAddCollectionViewController(navigationModel: AddNavigationModel) -> AddCollectionViewController {
        let assembler = Assembler(commonAssemblies + [AddCollectionAssembly()])
        let viewController = AddCollectionViewController()
        viewController.viewModel = assembler.resolver.resolve(IAddCollectionViewModel.self, argument: navigationModel)
        return viewController
    }

    //MARK: EditCollection
    static func makeEditCollectionViewController(navigationModel: CollectionNavigationModel) -> EditCollectionViewController {
        let assembler = Assembler(commonAssemblies + [EditCollectionAssembly()])
        let viewController = EditCollectionViewController()
        viewController.viewModel = assembler.resolver.resolve(IEditCollectionViewModel.self, argument: navigationModel)
        return viewController
    }

    //MARK: Diary
    static func makeDiaryViewController() -> DiaryViewController {
        let assembler = Assembler(commonAssemblies + [DiaryAssembly()])
        let viewController = DiaryViewController()
        viewController.viewModel = assembler.resolver.resolve(IDiaryViewModel.self)
        return viewController
    }

    //MARK: Note
    static func makeNotesViewController() -> NoteViewController {
        let assembler = Assembler(commonAssemblies + [NoteAssembly()])
        let viewController = NoteViewController()
        viewController.viewModel = assembler.resolver.resolve(INoteViewModel.self)
        return viewController
    }

    //MARK: AddNote
    static func makeAddNoteViewController(navigationModel: AddNavigationModel) -> AddNoteViewController {
        let assembler = Assembler(commonAssemblies + [AddNoteAssembly()])
        let viewController = AddNoteViewController()
        viewController.viewModel = assembler.resolver.resolve(IAddNoteViewModel.self, argument: navigationModel)
        return viewController
    }

    //MARK: EditNote
    static func makeEditNoteViewController(navigationModel: NoteNavigationModel) -> EditNoteViewController {
        let assembler = Assembler(commonAssemblies + [EditNoteAssembly()])
        let viewController = EditNoteViewController()
        viewController.viewModel = assembler.resolver.resolve(IEditNoteViewModel.self, argument: navigationModel)
        return viewController
    }

    //MARK: AddSale
    static func makeAddSaleViewController(navigationModel: AddNavigationModel) -> AddSaleViewController {
        let assembler = Assembler(commonAssemblies + [AddSaleAssembly()])
        let viewController = AddSaleViewController()
        viewController.viewModel = assembler.resolver.resolve(IAddSaleViewModel.self, argument: navigationModel)
        return viewController
    }

    //MARK: Main
    static func makeMainViewController() -> MainViewController {
        let assembler = Assembler(commonAssemblies + [MainAssembly()])
        let viewController = MainViewController()
        viewController.viewModel = assembler.resolver.resolve(IMainViewModel.self)
        return viewController
    }

    //MARK: Detail
    static func makeDetailViewController() -> DetailViewController {
        let assembler = Assembler(commonAssemblies + [DetailAssembly()])
        let viewController = DetailViewController()
        viewController.viewModel = assembler.resolver.resolve(IDetailViewModel.self)
        return viewController
    }

    //MARK: Feature
    static func makeFeatureViewController() -> FeatureViewController {
        let assembler = Assembler(commonAssemblies + [FeatureAssembly()])
        let viewController = FeatureViewController()
        viewController.viewModel = assembler.resolver.resolve(IFeatureViewModel.self)
        return viewController
    }

}
