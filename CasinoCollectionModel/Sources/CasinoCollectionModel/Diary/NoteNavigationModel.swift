//
//  NoteNavigationModel.swift
//  
//
//  Created by Er Baghdasaryan on 23.11.24.
//

import Foundation
import Combine

public final class NoteNavigationModel {
    public var activateSuccessSubject: PassthroughSubject<Bool, Never>
    public var model: NoteModel
    
    public init(activateSuccessSubject: PassthroughSubject<Bool, Never>, model: NoteModel) {
        self.activateSuccessSubject = activateSuccessSubject
        self.model = model
    }
}
