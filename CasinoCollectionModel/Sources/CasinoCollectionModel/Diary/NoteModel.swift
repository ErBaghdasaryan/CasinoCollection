//
//  NoteModel.swift
//
//
//  Created by Er Baghdasaryan on 23.11.24.
//

import UIKit

public struct NoteModel {
    public let id: Int?
    public let title: String
    public let text: String

    public init(id: Int? = nil, title: String, text: String) {
        self.id = id
        self.title = title
        self.text = text
    }
}
