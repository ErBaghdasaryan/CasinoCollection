//
//  AddNoteViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 23.11.24.
//

import Foundation
import CasinoCollectionModel
import Combine

public protocol IAddNoteViewModel {
    func addNote(model: NoteModel)
}

public class AddNoteViewModel: IAddNoteViewModel {

    private let diaryService: IDiaryService
    public var notes: [NoteModel] = []
    public var activateSuccessSubject = PassthroughSubject<Bool, Never>()

    public init(diaryService: IDiaryService, navigationModel: AddNavigationModel) {
        self.diaryService = diaryService
        self.activateSuccessSubject = navigationModel.activateSuccessSubject
    }

    public func addNote(model: NoteModel) {
        do {
            _ = try self.diaryService.addNote(model)
            self.activateSuccessSubject.send(true)
        } catch {
            print(error)
        }
    }
}
