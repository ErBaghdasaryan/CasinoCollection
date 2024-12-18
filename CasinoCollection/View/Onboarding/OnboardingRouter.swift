//
//  OnboardingRouter.swift
//  CasinoCollection
//
//  Created by Er Baghdasaryan on 21.11.24.
//

import Foundation
import UIKit
import CasinoCollectionViewModel

final class OnboardingRouter: BaseRouter {
    static func showHomeViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makeHomeViewController()
        viewController.navigationItem.hidesBackButton = true
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(viewController, animated: true)
    }
}
