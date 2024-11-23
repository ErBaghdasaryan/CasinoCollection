//
//  NoteViewModel.swift
//
//
//  Created by Er Baghdasaryan on 23.11.24.
//

import Foundation
import CasinoCollectionModel
import Combine

public protocol INoteViewModel {
    var notes: [NoteModel] { get set }
    func loadNotes()
    var activateSuccessSubject: PassthroughSubject<Bool, Never> { get }
}

public class NoteViewModel: INoteViewModel {

    private let diaryService: IDiaryService
    public var notes: [NoteModel] = []
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
}
