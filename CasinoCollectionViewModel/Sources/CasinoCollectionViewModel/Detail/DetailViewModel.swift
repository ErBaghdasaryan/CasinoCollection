//
//  DetailViewModel.swift
//
//
//  Created by Er Baghdasaryan on 16.12.24.
//

import Foundation
import CasinoCollectionModel

public protocol IDetailViewModel {

}

public class DetailViewModel: IDetailViewModel {

    private let detailService: IDetailService

    public init(detailService: IDetailService) {
        self.detailService = detailService
    }
}
