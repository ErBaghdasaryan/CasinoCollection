//
//  CollectionRouter.swift
//  CasinoCollection
//
//  Created by Er Baghdasaryan on 22.11.24.
//

import UIKit
import CasinoCollectionViewModel
import CasinoCollectionModel
import Swinject
import SwinjectAutoregistration

final class CollectionRouter: BaseRouter {

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
}
