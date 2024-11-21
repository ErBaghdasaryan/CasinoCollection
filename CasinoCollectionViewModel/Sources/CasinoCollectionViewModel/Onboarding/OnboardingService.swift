//
//  OnboardingService.swift
//  
//
//  Created by Er Baghdasaryan on 21.11.24.
//

import UIKit
import CasinoCollectionModel

public protocol IOnboardingService {
    func getOnboardingItems() -> [OnboardingPresentationModel]
}

public class OnboardingService: IOnboardingService {
    public init() { }

    public func getOnboardingItems() -> [OnboardingPresentationModel] {
        [
            OnboardingPresentationModel(image: "firstOnboarding",
                                        description: "The collection is always at hand"),
            OnboardingPresentationModel(image: "secondOnboarding",
                                        description: "Edit your recordings at any time")
        ]
    }
}
