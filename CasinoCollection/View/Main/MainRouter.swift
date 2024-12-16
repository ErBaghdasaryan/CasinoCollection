//
//  MainRouter.swift
//  CasinoCollection
//
//  Created by Er Baghdasaryan on 16.12.24.
//

import Foundation
import UIKit
import CasinoCollectionViewModel

final class MainRouter: BaseRouter {
    static func showDetailViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makeDetailViewController()
        viewController.navigationItem.hidesBackButton = true
        navigationController.navigationBar.isHidden = false
        navigationController.pushViewController(viewController, animated: true)
    }
}
