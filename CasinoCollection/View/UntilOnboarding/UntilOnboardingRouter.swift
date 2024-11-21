//
//  UntilOnboardingRouter.swift
//  CasinoCollection
//
//  Created by Er Baghdasaryan on 21.11.24.
//

import UIKit
import CasinoCollectionModel

final class UntilOnboardingRouter: BaseRouter {

    static func showTabBarViewController(in navigationController: UINavigationController) {
//        let viewController = ViewControllerFactory.makeTabBarViewController()
//        viewController.navigationItem.hidesBackButton = true
//        navigationController.navigationBar.isHidden = true
//        navigationController.pushViewController(viewController, animated: true)
    }

    static func showOnboardingViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makeOnboardingViewController()
        viewController.navigationItem.hidesBackButton = true
        navigationController.pushViewController(viewController, animated: true)
    }
}
