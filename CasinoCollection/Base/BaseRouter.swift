//
//  BaseRouter.swift
//  CasinoCollection
//
//  Created by Er Baghdasaryan on 21.11.24.
//

import UIKit
import Combine
import CasinoCollectionViewModel

class BaseRouter {

    class func popViewController(in navigationController: UINavigationController) {
        navigationController.popViewController(animated: true)
    }
}
