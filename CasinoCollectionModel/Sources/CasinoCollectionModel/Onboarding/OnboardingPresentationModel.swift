//
//  OnboardingPresentationModel.swift
//
//
//  Created by Er Baghdasaryan on 21.11.24.
//

import Foundation

public struct OnboardingPresentationModel {
    public let image: String
    public let description: String

    public init(image: String, description: String) {
        self.image = image
        self.description = description
    }
}
