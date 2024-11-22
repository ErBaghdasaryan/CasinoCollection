//
//  SettingsRouter.swift
//  CasinoCollection
//
//  Created by Er Baghdasaryan on 22.11.24.
//

import Foundation
import UIKit
import CasinoCollectionViewModel

final class SettingsRouter: BaseRouter {
    static func showUsageViewController(in navigationController: UIViewController) {
        let viewController = ViewControllerFactory.makeUsageViewController()
        navigationController.navigationItem.hidesBackButton = false
        navigationController.present(viewController, animated: true)
    }
}
