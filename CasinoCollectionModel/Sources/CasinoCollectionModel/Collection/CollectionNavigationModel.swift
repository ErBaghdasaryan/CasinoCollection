//
//  CollectionNavigationModel.swift
//
//
//  Created by Er Baghdasaryan on 22.11.24.
//

import Foundation
import Combine

public final class CollectionNavigationModel {
    public var activateSuccessSubject: PassthroughSubject<Bool, Never>
    public var model: CollectionModel
    
    public init(activateSuccessSubject: PassthroughSubject<Bool, Never>, model: CollectionModel) {
        self.activateSuccessSubject = activateSuccessSubject
        self.model = model
    }
}
