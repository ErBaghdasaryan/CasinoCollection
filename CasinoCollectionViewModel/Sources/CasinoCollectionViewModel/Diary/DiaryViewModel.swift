//
//  DiaryViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 23.11.24.
//

import Foundation
import CasinoCollectionModel
import Combine

public protocol IDiaryViewModel {
    var notes: [NoteModel] { get set }
    var sales: [SaleModel] { get set }
    func loadNotes()
    func loadSales()
    var activateSuccessSubject: PassthroughSubject<Bool, Never> { get }
}

public class DiaryViewModel: IDiaryViewModel {

    private let diaryService: IDiaryService
    public var notes: [NoteModel] = []
    public var sales: [SaleModel] = []
    public var activateSuccessSubject = PassthroughSubject<Bool, Never>()

    public init(diaryService: IDiaryService) {
        self.diaryService = diaryService
    }

    public func loadNotes() {
        do {
            self.notes = try self.diaryService.getNotes()
        } catch {
            print(error)
        }
    }

    public func loadSales() {
        do {
            self.sales = try self.diaryService.getSales()
        } catch {
            print(error)
        }
    }
}
