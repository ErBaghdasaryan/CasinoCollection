//
//  NoteRouter.swift
//  CasinoCollection
//
//  Created by Er Baghdasaryan on 23.11.24.
//

import Foundation
import UIKit
import CasinoCollectionViewModel
import CasinoCollectionModel

final class NoteRouter: BaseRouter {

    static func showAddNotesViewController(in navigationController: UINavigationController, navigationModel: AddNavigationModel) {
        let viewController = ViewControllerFactory.makeAddNoteViewController(navigationModel: navigationModel)
        viewController.navigationItem.hidesBackButton = false
        navigationController.navigationBar.isHidden = false
        navigationController.pushViewController(viewController, animated: true)
    }

    static func showEditNotesViewController(in navigationController: UINavigationController, navigationModel: NoteNavigationModel) {
        let viewController = ViewControllerFactory.makeEditNoteViewController(navigationModel: navigationModel)
        viewController.navigationItem.hidesBackButton = false
        navigationController.navigationBar.isHidden = false
        navigationController.pushViewController(viewController, animated: true)
    }
}

