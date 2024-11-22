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

}
