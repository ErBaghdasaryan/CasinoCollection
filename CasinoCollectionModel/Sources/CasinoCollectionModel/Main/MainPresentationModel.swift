//
//  MainPresentationModel.swift
//  
//
//  Created by Er Baghdasaryan on 16.12.24.
//

import Foundation

public struct MainPresentationModel {
    public let image: String
    public let description: String

    public init(image: String, description: String) {
        self.image = image
        self.description = description
    }
}
