//
//  HomeRouter.swift
//  CasinoCollection
//
//  Created by Er Baghdasaryan on 21.11.24.
//

import Foundation
import UIKit
import CasinoCollectionViewModel
import CasinoCollectionModel

final class HomeRouter: BaseRouter {
    static func showCollectionViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makeCollectionViewController()
        viewController.navigationItem.hidesBackButton = false
        navigationController.navigationBar.isHidden = false
        navigationController.pushViewController(viewController, animated: true)
    }

    static func showAddCollectionViewController(in navigationController: UINavigationController, navigationModel: AddNavigationModel) {
        let viewController = ViewControllerFactory.makeAddCollectionViewController(navigationModel: navigationModel)
        viewController.navigationItem.hidesBackButton = false
        navigationController.modalPresentationStyle = .pageSheet
        navigationController.present(viewController, animated: true)
    }

    static func showEditCollectionViewController(in navigationController: UINavigationController, navigationModel: CollectionNavigationModel) {
        let viewController = ViewControllerFactory.makeEditCollectionViewController(navigationModel: navigationModel)
        viewController.navigationItem.hidesBackButton = false
        navigationController.modalPresentationStyle = .pageSheet
        navigationController.present(viewController, animated: true)
    }

    static func showSettingsViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makeSettingsViewController()
        viewController.navigationItem.hidesBackButton = false
        navigationController.modalPresentationStyle = .pageSheet
        navigationController.present(viewController, animated: true)
    }

    static func showDiaryViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makeDiaryViewController()
        viewController.navigationItem.hidesBackButton = false
        navigationController.navigationBar.isHidden = false
        navigationController.pushViewController(viewController, animated: true)
    }
}
