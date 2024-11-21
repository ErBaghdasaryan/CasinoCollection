//
//  ServiceAssembly.swift
//  CasinoCollection
//
//  Created by Er Baghdasaryan on 21.11.24.
//

import Foundation
import Swinject
import SwinjectAutoregistration
import CasinoCollectionViewModel

public final class ServiceAssembly: Assembly {

    public init() {}

    public func assemble(container: Container) {
        container.autoregister(IAppStorageService.self, initializer: AppStorageService.init)
    }
}
