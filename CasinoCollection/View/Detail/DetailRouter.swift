//
//  DetailRouter.swift
//  CasinoCollection
//
//  Created by Er Baghdasaryan on 16.12.24.
//

import Foundation
import UIKit
import CasinoCollectionViewModel

final class DetailRouter: BaseRouter {
    static func showFeatureViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makeFeatureViewController()
        viewController.navigationItem.hidesBackButton = true
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(viewController, animated: true)
    }
}
