//
//  EditNoteViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 23.11.24.
//

import Foundation
import CasinoCollectionModel
import Combine

public protocol IEditNoteViewModel {
    func deleteNote(by id: Int)
    var note: NoteModel { get set }
}

public class EditNoteViewModel: IEditNoteViewModel {

    private let diaryService: IDiaryService
    public var note: NoteModel
    public var activateSuccessSubject = PassthroughSubject<Bool, Never>()

    public init(diaryService: IDiaryService, navigationModel: NoteNavigationModel) {
        self.diaryService = diaryService
        self.activateSuccessSubject = navigationModel.activateSuccessSubject
        self.note = navigationModel.model
    }

    public func deleteNote(by id: Int) {
        do {
            try self.diaryService.deleteNote(byID: id)
            self.activateSuccessSubject.send(true)
        } catch {
            print(error)
        }
    }
}
